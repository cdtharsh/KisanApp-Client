import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import 'controller/signup_controller.dart';
import '../../widgets/layouts/text_feild.dart';
import '../../utils/validator/validator.dart';

class SignupFormWidget extends StatefulWidget {
  const SignupFormWidget({super.key});

  @override
  SignupFormWidgetState createState() => SignupFormWidgetState();
}

class SignupFormWidgetState extends State<SignupFormWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final controllers = SignupControllers();
  bool isLoading = false;
  String? passwordStrengthMessage;
  List<bool> passwordRequirementsMet = [false, false, false, false, false];
  bool _isPasswordVisible = false;
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                controller: controllers.usernameController,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('@',
                      style: TextStyle(color: Colors.redAccent, fontSize: 20)),
                ),
                hintText: kUserName,
                labelText: kUserName,
                obscureText: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: (value) => CustomValidator.validateField(
                    value, 'Please enter your username'),
              ),
              const SizedBox(height: kFieldSpace),
              CommonTextField(
                controller: controllers.emailController,
                hintText: kEmail,
                labelText: kEmail,
                prefixIcon: const Icon(Icons.email, color: Colors.redAccent),
                validator: (value) => CustomValidator.validateEmail(
                    value, 'Please enter a valid email address'),
              ),
              const SizedBox(height: kFieldSpace),
              CommonTextField(
                controller: controllers.passwordController,
                focusNode: _passwordFocusNode,
                hintText: kPass,
                labelText: kPass,
                prefixIcon: const Icon(Icons.lock, color: Colors.redAccent),
                obscureText: !_isPasswordVisible,
                onChanged: (value) {
                  setState(() {
                    passwordRequirementsMet =
                        CustomValidator.checkPasswordRequirements(value);
                  });
                },
                suffixIcon: GestureDetector(
                  onTapDown: (_) {
                    setState(() {
                      _isPasswordVisible = true;
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      _isPasswordVisible = false;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      _isPasswordVisible = false;
                    });
                  },
                  child: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              if (_passwordFocusNode.hasFocus)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPasswordRequirement(
                        "At least 8 characters (e.g., 'abcdefgh')",
                        passwordRequirementsMet[0]),
                    _buildPasswordRequirement(
                        "Contains at least one letter (e.g., 'a')",
                        passwordRequirementsMet[1]),
                    _buildPasswordRequirement(
                        "Contains at least one number (e.g., '1')",
                        passwordRequirementsMet[2]),
                    _buildPasswordRequirement(
                        "Contains at least one special character (e.g., @, #, etc.)",
                        passwordRequirementsMet[3]),
                    _buildPasswordRequirement(
                        "Contains at least one capital letter (e.g., 'A')",
                        passwordRequirementsMet[4]),
                  ],
                ),
              const SizedBox(height: kFieldSpace),
              CommonTextField(
                controller: controllers.confirmPasswordController,
                hintText: kConfirmPass,
                labelText: kConfirmPass,
                prefixIcon: const Icon(Icons.lock, color: Colors.redAccent),
                obscureText: false,
                validator: (value) {
                  if (value != controllers.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: kFieldSpace),
              PhoneFormField(
                controller: controllers.mobileController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: const Icon(Icons.call, color: Colors.redAccent),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                validator: CustomValidator.getPhoneValidator(context,
                    mobileOnly: true),
                countrySelectorNavigator:
                    const CountrySelectorNavigator.bottomSheet(),
                isCountryButtonPersistent: true,
              ),
              const SizedBox(height: kFieldSpace),
              CommonTextField(
                controller: controllers.firstNameController,
                hintText: kFirstName,
                labelText: kFirstName,
                prefixIcon: const Icon(Icons.person, color: Colors.redAccent),
                validator: (value) => CustomValidator.validateField(
                    value, 'Please enter your first name'),
              ),
              const SizedBox(height: kFieldSpace),
              CommonTextField(
                controller: controllers.lastNameController,
                hintText: kLastName,
                labelText: kLastName,
                prefixIcon: const Icon(Icons.person, color: Colors.redAccent),
                validator: (value) => CustomValidator.validateField(
                    value, 'Please enter your last name'),
              ),
              const SizedBox(height: kFieldSpace),
              CSCPicker(
                showStates: true,
                showCities: true,
                defaultCountry: CscCountry.India,
                onCountryChanged: (value) => controllers.countryValue = value,
                onStateChanged: (value) => controllers.stateValue = value ?? '',
                onCityChanged: (value) => controllers.cityValue = value ?? '',
                dropdownDecoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(1, 3), // Shifts shadow downward
                      blurRadius: 25, // Slightly blurs the shadow
                      spreadRadius:
                          0, // Ensures the shadow does not spread on all sides
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25.0),
                  color: theme.colorScheme.surface,
                  border: Border.all(
                    color: theme.brightness == Brightness.dark
                        ? Colors.white60 // Lighter border for dark theme
                        : Colors.blueAccent, // Blue accent for light theme
                    width: 1,
                  ),
                ),
                disabledDropdownDecoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(1, 3), // Shifts shadow downward
                      blurRadius: 25, // Slightly blurs the shadow
                      spreadRadius:
                          0, // Ensures the shadow does not spread on all sides
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25.0),
                  color: theme.colorScheme.surface,
                  border: Border.all(
                    color: theme.brightness == Brightness.dark
                        ? Colors.white60 // Lighter border for dark theme
                        : Colors.blueAccent, // Blue accent for light theme
                    width: 1,
                  ),
                ),
              ),
              const SizedBox(height: kFieldSpace),
              CommonTextField(
                controller: controllers.streetAddressController,
                hintText: kStreetAddress,
                labelText: kStreetAddress,
                prefixIcon:
                    const Icon(Icons.location_on, color: Colors.redAccent),
                validator: (value) => CustomValidator.validateField(
                    value, 'Please enter your street address'),
              ),
              const SizedBox(height: kFieldSpace),
              CommonTextField(
                controller: controllers.postalCodeController,
                hintText: kPostalCode,
                labelText: kPostalCode,
                prefixIcon: const Icon(Icons.code, color: Colors.redAccent),
                keyboardType: TextInputType.number,
                validator: (value) => CustomValidator.validateField(
                    value, 'Please enter your postal code'),
              ),
              const SizedBox(height: kFieldSpace),
              ElevatedButton(
                onPressed: isLoading ? null : _submitForm,
                child: isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : Text(kSignup.toUpperCase()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(String text, bool isMet) {
    return Row(
      children: [
        Icon(isMet ? Icons.check : Icons.close,
            color: isMet ? Colors.green : Colors.red),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }

  Future<void> _submitForm() async {
    setState(() {
      isLoading = true;
    });

    controllers.updateAddress();

    try {
      if (formKey.currentState?.validate() ?? false) {
        await controllers.handleRegister();
      }
    } catch (e) {
      // Handle errors gracefully
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
