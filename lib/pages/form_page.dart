import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/turtle_model.dart';
import '../services/supabase_service.dart';

class FormPage extends StatefulWidget {
  final TurtleModel? turtle;
  
  const FormPage({super.key, this.turtle});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _lokasiCtrl = TextEditingController();
  final _jumlahTelurCtrl = TextEditingController();
  final _jumlahTukikCtrl = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();
  String _statusTelur = 'Belum Menetas';
  bool _isLoading = false;

  final List<String> _statusOptions = ['Belum Menetas', 'Sudah Menetas'];

  @override
  void initState() {
    super.initState();
    if (widget.turtle != null) {
      _namaCtrl.text = widget.turtle!.namaPenyu;
      _lokasiCtrl.text = widget.turtle!.lokasiSarang;
      _jumlahTelurCtrl.text = widget.turtle!.jumlahTelur.toString();
      _jumlahTukikCtrl.text = widget.turtle!.jumlahTukikDilepas.toString();
      _selectedDate = widget.turtle!.tanggalBertelur;
      _statusTelur = widget.turtle!.statusTelur;
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final turtle = TurtleModel(
      namaPenyu: _namaCtrl.text,
      lokasiSarang: _lokasiCtrl.text,
      jumlahTelur: int.parse(_jumlahTelurCtrl.text),
      tanggalBertelur: _selectedDate,
      statusTelur: _statusTelur,
      jumlahTukikDilepas: int.parse(_jumlahTukikCtrl.text),
    );

    bool success;
    if (widget.turtle == null) {
      success = await SupabaseService.insertTurtle(turtle);
    } else {
      success = await SupabaseService.updateTurtle(widget.turtle!.id!, turtle);
    }

    setState(() => _isLoading = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.turtle == null 
              ? 'Data berhasil ditambahkan' 
              : 'Data berhasil diupdate'),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.turtle != null;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Data Penyu' : 'Tambah Data Penyu'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF006994), Color(0xFF2E8B57)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Card(
                color: const Color(0xFF006994).withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Isi data konservasi dengan lengkap dan akurat',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Form Fields
              _buildTextField(
                controller: _namaCtrl,
                label: 'Nama/Jenis Penyu',
                icon: Icons.pets,
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              
              _buildTextField(
                controller: _lokasiCtrl,
                label: 'Lokasi Sarang',
                icon: Icons.location_on,
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              
              _buildTextField(
                controller: _jumlahTelurCtrl,
                label: 'Jumlah Telur',
                icon: Icons.egg,
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              
              // Date Picker
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Tanggal Bertelur',
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    DateFormat('dd MMMM yyyy').format(_selectedDate),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Status Dropdown
              DropdownButtonFormField<String>(
                value: _statusTelur,
                decoration: InputDecoration(
                  labelText: 'Status Telur',
                  prefixIcon: const Icon(Icons.hourglass_empty),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _statusOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() => _statusTelur = newValue!);
                },
              ),
              const SizedBox(height: 16),
              
              _buildTextField(
                controller: _jumlahTukikCtrl,
                label: 'Jumlah Tukik Dilepas',
                icon: Icons.water,
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 32),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _saveData,
                  icon: _isLoading 
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.save),
                  label: Text(
                    _isLoading ? 'Menyimpan...' : (isEdit ? 'UPDATE DATA' : 'SIMPAN DATA'),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E8B57),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF006994), width: 2),
        ),
      ),
    );
  }
}