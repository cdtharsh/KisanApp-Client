import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Adjust padding without ScreenUtil
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonTextField(
              controller: controllers.usernameController,
              prefixIcon:
                  const Icon(Clarity.user_line, color: Colors.redAccent),
              hintText: kUserName,
              labelText: kUserName,
              obscureText: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              validator: (value) => CustomValidator.validateField(
                  value, 'Please enter your username'),
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              controller: controllers.firstNameController,
              hintText: kFirstName,
              labelText: kFirstName,
              prefixIcon:
                  const Icon(MingCute.user_1_fill, color: Colors.redAccent),
              validator: (value) => CustomValidator.validateField(
                  value, 'Please enter your first name'),
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              controller: controllers.lastNameController,
              hintText: kLastName,
              labelText: kLastName,
              prefixIcon:
                  const Icon(MingCute.user_2_fill, color: Colors.redAccent),
              validator: (value) => CustomValidator.validateField(
                  value, 'Please enter your last name'),
            ),
            const SizedBox(height: kFormHeight),

            // Phone Field with custom validation
            PhoneFormField(
              controller: controllers.mobileController,
              decoration: InputDecoration(
                labelText: 'Phone',
                prefixIcon: const Icon(Icons.call, color: Colors.redAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              validator:
                  CustomValidator.getPhoneValidator(context, mobileOnly: true),
              countrySelectorNavigator:
                  const CountrySelectorNavigator.bottomSheet(),
              isCountryButtonPersistent: true,
              autofocus: true,
            ),

            const SizedBox(height: kFormHeight),
            CommonTextField(
              controller: controllers.emailController,
              hintText: kEmail,
              labelText: kEmail,
              prefixIcon: const Icon(Icons.email, color: Colors.redAccent),
              validator: (value) => CustomValidator.validateField(
                  value, 'Please enter your email address'),
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              controller: controllers.passwordController,
              hintText: kPass,
              labelText: kPass,
              prefixIcon: const Icon(Icons.lock, color: Colors.redAccent),
              obscureText: true,
              validator: (value) => CustomValidator.validateField(
                  value, 'Please enter your password'),
            ),
            const SizedBox(height: kFormHeight),
            // CSC Picker for Country, State, and City
            CSCPicker(
              showStates: true,
              showCities: true,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              disabledDropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              defaultCountry: CscCountry.India,
              countrySearchPlaceholder: "Country",
              stateSearchPlaceholder: "State",
              citySearchPlaceholder: "City",
              countryDropdownLabel: "Country",
              stateDropdownLabel: "State",
              cityDropdownLabel: "City",

              // When country is changed
              onCountryChanged: (value) {
                setState(() {
                  controllers.countryValue = value; // Store the country name
                  controllers
                      .updateAddress(); // Update the address whenever the country changes
                });
              },

              // When state is changed
              onStateChanged: (value) {
                setState(() {
                  controllers.stateValue =
                      value ?? ""; // Ensure value is not null
                  controllers
                      .updateAddress(); // Update the address whenever the state changes
                });
              },

              // When city is changed
              onCityChanged: (value) {
                setState(() {
                  controllers.cityValue =
                      value ?? ""; // Ensure value is not null
                  controllers
                      .updateAddress(); // Update the address whenever the city changes
                });
              },
            ),
            const SizedBox(height: kFormHeight),

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

            // Postal Code TextField
            CommonTextField(
              controller: controllers.postalCodeController,
              hintText: kPostalCode,
              labelText: kPostalCode,
              prefixIcon: const Icon(Icons.pin, color: Colors.redAccent),
              validator: (value) => CustomValidator.validateField(
                  value, 'Please enter your postal code'),
            ),
            const SizedBox(height: kFormHeight),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                // Update and print the full address
                controllers.updateAddress();
                controllers.register();
                // Proceed with signup logic
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
              child: const Text(kSignup),
            ),
          ],
        ),
      ),
    );
  }
}
