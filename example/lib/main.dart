import 'package:flutter/material.dart';
import 'package:tf_form/tf_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(backgroundColor: Colors.white),
      home: const DemoFormPage(),
    );
  }
}

class DemoFormPage extends StatefulWidget {
  const DemoFormPage({super.key});

  @override
  DemoFormPageState createState() {
    return DemoFormPageState();
  }
}

class DemoFormPageState extends State<DemoFormPage> {
  final _personalFormKey = GlobalKey<TFFormState>();
  final nicknameController = TextEditingController();
  final emailController = TextEditingController();
  final birthdayController = TextEditingController();
  final phoneController = TextEditingController();

  final _addressesFormKey = GlobalKey<TFFormState>();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final addressTypeController = TextEditingController();

  final _securityFormKey = GlobalKey<TFFormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Personal Info"),
              Tab(text: "Addresses"),
              Tab(text: "Security"),
            ],
          ),
          title: const Text('Form Validation Demo'),
        ),
        body: TabBarView(
          children: [
            _buildPersonalInfoTab(),
            _buildAddressesTab(),
            _buildPSecurityTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoTab() {
    return TFForm(
      key: _personalFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TFFormField(
              label: "Nickname",
              hintText: "Enter a nickname",
              controller: nicknameController,
              validationTypes: const [
                TFValidationType.required,
              ],
            ),
            const SizedBox(height: 10),
            TFFormField(
              label: "Email",
              hintText: "ben@somewhere.com",
              controller: emailController,
              validationTypes: const [
                TFValidationType.required,
                TFValidationType.emailAddress,
              ],
            ),
            const SizedBox(height: 10),
            TFFormField(
              label: "Birthday",
              hintText: "dd-mm-yyyy",
              controller: birthdayController,
              validationTypes: const [],
              suffix: const Icon(Icons.arrow_drop_down),
              readOnly: true,
              onTap: () async {
                final result = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 200)),
                  lastDate: DateTime.now().add(const Duration(days: 200)),
                );
                if (result != null) {
                  birthdayController.text = "${result.day}-${result.month}-${result.year}";
                }
              },
            ),
            const SizedBox(height: 10),
            TFFormField(
              label: "Phone",
              hintText: "Enter a phone",
              controller: phoneController,
              validationTypes: const [
                TFValidationType.required,
                TFValidationType.phone,
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _personalFormKey.currentState!.validate();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressesTab() {
    return TFForm(
      key: _addressesFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TFFormField(
              label: "Type",
              controller: addressTypeController,
              validationTypes: const [],
            ),
            const SizedBox(height: 10),
            TFFormField(
              label: "Address 1",
              controller: address1Controller,
              validationTypes: const [
                TFValidationType.required,
              ],
            ),
            const SizedBox(height: 10),
            TFFormField(
              label: "Address 2",
              controller: address2Controller,
              validationTypes: const [],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _addressesFormKey.currentState!.validate();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPSecurityTab() {
    return TFForm(
      key: _securityFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TFFormField(
              label: "New password",
              controller: passwordController,
              validationTypes: const [
                TFValidationType.required,
                TFValidationType.password,
              ],
            ),
            const SizedBox(height: 10),
            TFFormField(
              label: "Confirm",
              controller: confirmPasswordController,
              passwordController: passwordController,
              validationTypes: const [
                TFValidationType.required,
                TFValidationType.confirmPassword,
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _securityFormKey.currentState!.validate();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
