// lib/screens/estimation_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/row_item.dart';
import '../utils/estimation_calculator.dart';
import '../widgets/chart_widget.dart';
import '../widgets/sidebar.dart';
import '../widgets/nav_bar.dart';

class EstimationScreen extends StatefulWidget {
  const EstimationScreen({super.key});

  @override
  State<EstimationScreen> createState() => _EstimationScreenState();
}

class _EstimationScreenState extends State<EstimationScreen> {
  // ... متغیرهای کلاس ...

  @override
  void initState() {
    super.initState();
    _addNewRow();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_searchController.text.length > 2) {
      _searchItems(_searchController.text);
    } else {
      setState(() {
        _searchResults.clear();
      });
    }
  }

  // حذف تعریف تکراری _onSearchChanged از اینجا

  Future<void> _searchFromAPI(String query) async {
    // ... کد متد ...
  }

  void _useSearchResult(Map<String, dynamic> result) {
    // ... کد متد ...
  }

  void _searchFromWeb(String query) async {
    // ... کد متد ...
  }

  void _searchItems(String query) {
    // این متد باید لیست آیتم‌ها را بر اساس کوئری جستجو کند
    setState(() {
      _isSearching = true;
    });
    
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _searchResults = _items.where((item) {
          return item.description.toLowerCase().contains(query.toLowerCase());
        }).map((item) {
          return {
            'description': item.description,
            'unit': item.unit,
            'averagePrice': item.unitPrice,
            'category': item.category,
            'source': 'داده‌های محلی'
          };
        }).toList();
        
        _isSearching = false;
      });
    });
  }

  void _searchMaterials(String query) {
    // این متد باید مواد و مصالح را از یک منبع داخلی جستجو کند
    final sampleMaterials = [
      {
        'description': 'سیمان پرتلند',
        'unit': 'کیلوگرم',
        'averagePrice': 12000,
        'category': 'نازک کاری',
        'source': 'داده‌های داخلی'
      },
      {
        'description': 'آجر فشاری',
        'unit': 'عدد',
        'averagePrice': 2500,
        'category': 'اسکلت',
        'source': 'داده‌های داخلی'
      },
      {
        'description': 'تیرآهن ۱۴',
        'unit': 'متر',
        'averagePrice': 85000,
        'category': 'اسکلت',
        'source': 'داده‌های داخلی'
      },
    ];
    
    setState(() {
      _searchResults = sampleMaterials.where((material) {
        return material['description'].toString().toLowerCase().contains(query.toLowerCase());
      }).toList();
      
      _isSearching = false;
    });
  }

  // ... بقیه متدها ...
  
  @override
  Widget build(BuildContext context) {
    // ... کد ویو ...
  }
}
