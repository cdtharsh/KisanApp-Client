import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:validators/validators.dart' as validators;

import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../signup_form/text_feild.dart';

class SignupFormWidget extends StatelessWidget {
  const SignupFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController mobileController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController streetAddressController =
        TextEditingController();
    final TextEditingController postalCodeController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController stateController = TextEditingController();
    final TextEditingController cityController = TextEditingController();

    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonTextField(
              controller: usernameController,
              prefixIcon:
                  const Icon(Clarity.user_line, color: Colors.redAccent),
              hintText: kUserName,
              labelText: kUserName,
              obscureText: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              controller: firstNameController,
              hintText: kFirstName,
              labelText: kFirstName,
              prefixIcon:
                  const Icon(MingCute.user_1_fill, color: Colors.redAccent),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              controller: lastNameController,
              hintText: kLastName,
              labelText: kLastName,
              prefixIcon:
                  const Icon(MingCute.user_2_fill, color: Colors.redAccent),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              controller: mobileController,
              hintText: kPhone,
              labelText: kPhone,
              prefixIcon: const Icon(Icons.call, color: Colors.redAccent),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              controller: emailController,
              hintText: kEmail,
              labelText: kEmail,
              prefixIcon: const Icon(Icons.email, color: Colors.redAccent),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                } else if (!validators.isEmail(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              controller: passwordController,
              hintText: kPass,
              labelText: kPass,
              prefixIcon: const Icon(Icons.lock, color: Colors.redAccent),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              controller: streetAddressController,
              hintText: kStreetAddress,
              labelText: kStreetAddress,
              prefixIcon:
                  const Icon(Icons.location_on, color: Colors.redAccent),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your street address';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              controller: postalCodeController,
              hintText: kPostalCode,
              labelText: kPostalCode,
              prefixIcon: const Icon(Icons.pin, color: Colors.redAccent),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your postal code';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            DropdownButtonFormField<String>(
              value: countryController.text.isNotEmpty
                  ? countryController.text
                  : null,
              decoration: InputDecoration(
                labelText: 'Country',
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              items: ['India', 'USA', 'Canada']
                  .map((country) => DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      ))
                  .toList(),
              onChanged: (value) {
                countryController.text = value ?? '';
                stateController.clear();
                cityController.clear();
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a country';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            DropdownButtonFormField<String>(
              value:
                  stateController.text.isNotEmpty ? stateController.text : null,
              decoration: InputDecoration(
                labelText: 'State',
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              items: ['State 1', 'State 2', 'State 3']
                  .map((state) => DropdownMenuItem<String>(
                        value: state,
                        child: Text(state),
                      ))
                  .toList(),
              onChanged: (value) {
                stateController.text = value ?? '';
                cityController.clear();
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a state';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            DropdownButtonFormField<String>(
              value:
                  cityController.text.isNotEmpty ? cityController.text : null,
              decoration: InputDecoration(
                labelText: 'City',
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              items: ['City 1', 'City 2', 'City 3']
                  .map((city) => DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      ))
                  .toList(),
              onChanged: (value) {
                cityController.text = value ?? '';
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a city';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // Handle registration logic here
                }
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
