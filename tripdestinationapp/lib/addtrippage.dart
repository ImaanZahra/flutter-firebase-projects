import 'package:flutter/material.dart';
import 'home_page.dart';
import 'main.dart'; // To get access to Trip class and shared theme

class AddTripPage extends StatefulWidget {
  @override
  _AddTripPageState createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final _formKey = GlobalKey<FormState>();

  String? _city;
  String? _country;
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      _formKey.currentState!.save();

      final trip = Trip(
        city: _city!,
        country: _country!,
        date: "${_selectedDate!.day} ${_monthName(_selectedDate!.month)}, ${_selectedDate!.year}",
      );

      Navigator.pop(context, trip);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and select a date')),
      );
    }
  }

  String _monthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Add New Trip'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: textTheme.bodyLarge,
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade800),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.secondary),
                  ),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter city' : null,
                onSaved: (value) => _city = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                style: textTheme.bodyLarge,
                decoration: InputDecoration(
                  labelText: 'Country',
                  labelStyle: textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade800),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.secondary),
                  ),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter country' : null,
                onSaved: (value) => _country = value,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date chosen'
                          : "${_selectedDate!.day} ${_monthName(_selectedDate!.month)} ${_selectedDate!.year}",
                      style: textTheme.bodyMedium,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.secondary,
                    ),
                    onPressed: _pickDate,
                    child: Text('Choose Date', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.secondary,
                ),
                onPressed: _submit,
                child: Text('Add Trip', style: TextStyle(color: Colors.black)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
