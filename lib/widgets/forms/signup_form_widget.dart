import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../../controller/authentication/signup_controller.dart';
import '../signup_form/text_feild.dart';
import '../../validator/validator.dart';

class SignupFormWidget extends StatefulWidget {
  const SignupFormWidget({super.key});

  @override
  SignupFormWidgetState createState() => SignupFormWidgetState();
}

class SignupFormWidgetState extends State<SignupFormWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final controllers = SignupControllers();
  bool isLoading = false;

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
              // Username
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
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your username'
                    : null,
              ),
              const SizedBox(height: kFormHeight),

              // Email
              CommonTextField(
                controller: controllers.emailController,
                hintText: kEmail,
                labelText: kEmail,
                prefixIcon: const Icon(Icons.email, color: Colors.redAccent),
                validator: (value) => CustomValidator.validateEmail(
                    value, 'Please enter a valid email address'),
              ),
              const SizedBox(height: kFormHeight),

              // Password
              CommonTextField(
                controller: controllers.passwordController,
                hintText: kPass,
                labelText: kPass,
                prefixIcon: const Icon(Icons.lock, color: Colors.redAccent),
                obscureText: true,
                validator: (value) => CustomValidator.validatePassword(
                    value, 'Please enter a valid password'),
              ),
              const SizedBox(height: kFormHeight),

              // Phone Number
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
              const SizedBox(height: kFormHeight),

              // First Name
              CommonTextField(
                controller: controllers.firstNameController,
                hintText: kFirstName,
                labelText: kFirstName,
                prefixIcon: const Icon(Icons.person_2, color: Colors.redAccent),
                validator: (value) => CustomValidator.validateField(
                    value, 'Please enter your first name'),
              ),
              const SizedBox(height: kFormHeight),

              // Last Name
              CommonTextField(
                controller: controllers.lastNameController,
                hintText: kLastName,
                labelText: kLastName,
                prefixIcon: const Icon(Icons.person_3, color: Colors.redAccent),
                validator: (value) => CustomValidator.validateField(
                    value, 'Please enter your last name'),
              ),
              const SizedBox(height: kFormHeight),

              // Country, State, City Picker
              CSCPicker(
                showStates: true,
                showCities: true,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.cardColor,
                  border: Border.all(color: theme.dividerColor, width: 1),
                ),
                disabledDropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.disabledColor,
                  border: Border.all(color: theme.dividerColor, width: 1),
                ),
                defaultCountry: CscCountry.India,
                countrySearchPlaceholder: "Country",
                stateSearchPlaceholder: "State",
                citySearchPlaceholder: "City",
                countryDropdownLabel: "Country",
                stateDropdownLabel: "State",
                cityDropdownLabel: "City",
                onCountryChanged: (value) {
                  setState(() {
                    controllers.countryValue = value;
                    controllers.updateAddress();
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    controllers.stateValue = value ?? "";
                    controllers.updateAddress();
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    controllers.cityValue = value ?? "";
                    controllers.updateAddress();
                  });
                },
              ),
              const SizedBox(height: kFormHeight),

              // Street Address
              CommonTextField(
                controller: controllers.streetAddressController,
                hintText: kStreetAddress,
                labelText: kStreetAddress,
                prefixIcon:
                    const Icon(Icons.location_on, color: Colors.redAccent),
                validator: (value) => CustomValidator.validateField(
                    value, 'Please enter your street address'),
              ),
              const SizedBox(height: kFormHeight),

              // Postal Code
              CommonTextField(
                controller: controllers.postalCodeController,
                hintText: kPostalCode,
                labelText: kPostalCode,
                prefixIcon: const Icon(Icons.pin, color: Colors.redAccent),
                validator: (value) => CustomValidator.validateField(
                    value, 'Please enter your postal code'),
              ),
              const SizedBox(height: kFormHeight),

              // Signup Button
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            await controllers.handleRegister();
                          } catch (e) {
                            // Handle errors
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text(kSignup),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
