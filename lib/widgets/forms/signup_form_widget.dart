import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:validators/validators.dart' as validators;

import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../../controller/authentication/signup_controller.dart';
import '../signup_form/text_feild.dart';

class SignupFormWidget extends StatelessWidget {
  const SignupFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonTextField(
              controller: controller.username,
              prefixIcon: const Icon(
                Clarity.user_line,
                color: Colors.redAccent,
              ),
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
              hintText: kFirstName,
              controller: controller.firstName,
              labelText: kFirstName,
              prefixIcon: const Icon(
                MingCute.user_1_fill,
                color: Colors.redAccent,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              hintText: kLastName,
              controller: controller.lastName,
              labelText: kLastName,
              prefixIcon: const Icon(
                MingCute.user_2_fill,
                color: Colors.redAccent,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                controller.phoneNumber = number;
              },
              onSaved: (PhoneNumber number) {
                final formattedNumber = number.phoneNumber ?? '';
                controller.mobile.text = formattedNumber;
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                useBottomSheetSafeArea: true,
              ),
              ignoreBlank: true,
              initialValue: controller.phoneNumber,
              textFieldController: controller.mobile,
              formatInput: true,
              textStyle: Theme.of(context).textTheme.bodyLarge,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: false,
              ),
              inputDecoration: InputDecoration(
                icon: const Icon(Icons.call, color: Colors.redAccent),
                label: const Text(kPhone),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                hintText: 'Enter your phone number',
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                      color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                      color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                      color: Colors.transparent),
                ),
              ),
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              hintText: kEmail,
              controller: controller.email,
              labelText: kEmail,
              prefixIcon: const Icon(Icons.email, color: Colors.redAccent,),
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
              hintText: kPass,
              controller: controller.password,
              labelText: kPass,
              prefixIcon: const Icon(Icons.lock, color: Colors.redAccent,),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              hintText: kStreetAddress,
              controller: controller.streetAddress,
              labelText: kStreetAddress,
              prefixIcon: const Icon(Icons.location_on,color: Colors.redAccent,),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your street address';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            CommonTextField(
              hintText: kPostalCode,
              controller: controller.postalCode,
              labelText: kPostalCode,
              prefixIcon: const Icon(Icons.pin, color: Colors.redAccent,),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your postal code';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormHeight),
            CSCPicker(
              onCountryChanged: (value) {
                controller.country.text = value;
                controller.state.clear();
                controller.city.clear();
              },
              onStateChanged: (value) {
                controller.state.text = value ?? '';
                controller.city.clear();
              },
              onCityChanged: (value) {
                controller.city.text = value ?? '';
              },
              defaultCountry: CscCountry.India,
              showStates: true,
              showCities: true,
            ),
            const SizedBox(height: kFormHeight),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.registerUser();
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
