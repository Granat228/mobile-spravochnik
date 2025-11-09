import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Справочник по ИС',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'Справочник по ИС',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class Section {
  final String id;
  final String title;
  final String description;
  final String icon;
  final int color;
  final String content;
  bool isBookmarked;
  final DateTime createdAt;
  DateTime updatedAt;

  Section({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.content,
    this.isBookmarked = false,
    required this.createdAt,
    required this.updatedAt,
  });

  IconData get iconData {
    switch (icon) {
      case 'concept': return Icons.lightbulb;
      case 'types': return Icons.category;
      case 'database': return Icons.storage;
      case 'architecture': return Icons.architecture;
      case 'development': return Icons.developer_mode;
      case 'security': return Icons.security;
      case 'cloud': return Icons.cloud;
      case 'erp': return Icons.business;
      case 'analytics': return Icons.analytics;
      default: return Icons.info;
    }
  }

  Color get colorValue => Color(color);

  Section copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    int? color,
    String? content,
    bool? isBookmarked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Section(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      content: content ?? this.content,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'color': color,
      'content': content,
      'isBookmarked': isBookmarked,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? 'info',
      color: json['color'] ?? Colors.blue.value,
      content: json['content'] ?? '',
      isBookmarked: json['isBookmarked'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class DataService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<List<Section>> loadSections() async {
    await Future.delayed(Duration(seconds: 1));

    final savedData = _prefs?.getString('sections');
    if (savedData != null) {
      final List<dynamic> jsonList = json.decode(savedData);
      return jsonList.map((json) => Section.fromJson(json)).toList();
    }

    return [
      Section(
        id: '1',
        title: 'Основы ИС',
        description: 'Понятия и классификация информационных систем',
        icon: 'concept',
        color: Colors.blue.value,
        content: '''
# Основные понятия информационных систем

## Определение ИС:
Информационная система - это совокупность программных, технических средств и персонала, предназначенная для сбора, хранения, обработки и распространения информации.

## Классификация ИС:
- **По масштабу**: Персональные, групповые, корпоративные
- **По сфере применения**: Бухгалтерские, банковские, медицинские
- **По архитектуре**: Файл-серверные, клиент-серверные, многоуровневые

## Компоненты ИС:
1. **Аппаратное обеспечение** - серверы, компьютеры, сети
2. **Программное обеспечение** - ОС, СУБД, приложения
3. **Данные** - информация для обработки
4. **Персонал** - пользователи и администраторы
5. **Процедуры** - правила работы с системой

## Жизненный цикл ИС:
1. Анализ требований
2. Проектирование
3. Разработка
4. Тестирование
5. Внедрение
6. Эксплуатация и сопровождение
''',
        isBookmarked: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Section(
        id: '2',
        title: 'Типы ИС',
        description: 'Классификация информационных систем по назначению',
        icon: 'types',
        color: Colors.green.value,
        content: '''
# Типы информационных систем

## Операционные системы (TPS):
- Обработка транзакций в реальном времени
- Учет продаж, платежей, заказов
- Высокая надежность и производительность

## Системы управления (MIS):
- Поддержка принятия решений
- Аналитические отчеты
- Мониторинг ключевых показателей

## Системы поддержки решений (DSS):
- Сложные аналитические расчеты
- Моделирование ситуаций
- Что-если анализ

## Экспертные системы (ES):
- Базы знаний
- Логический вывод
- Рекомендательные системы

## ERP системы:
- Интеграция бизнес-процессов
- Управление ресурсами предприятия
- Модульная архитектура

## CRM системы:
- Управление взаимоотношениями с клиентами
- История взаимодействий
- Автоматизация продаж
''',
        isBookmarked: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Section(
        id: '3',
        title: 'Базы данных в ИС',
        description: 'Системы хранения и управления данными',
        icon: 'database',
        color: Colors.orange.value,
        content: '''
# Базы данных в информационных системах

## Реляционные СУБД:
- **Oracle Database** - промышленная СУБД
- **MySQL** - популярная открытая СУБД
- **PostgreSQL** - расширяемая объектно-реляционная СУБД
- **Microsoft SQL Server** - решение для Windows-сред

## NoSQL базы данных:
- **MongoDB** - документоориентированная БД
- **Redis** - хранилище ключ-значение в памяти
- **Cassandra** - распределенная колоночная БД
- **Neo4j** - графовая база данных

## Проектирование БД:
- Нормализация отношений
- ER-диаграммы
- Индексы и оптимизация
- Целостность данных

## Транзакции:
- Свойства ACID
- Уровни изоляции
- Управление блокировками
- Восстановление после сбоев
''',
        isBookmarked: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Section(
        id: '4',
        title: 'Архитектура ИС',
        description: 'Структура и компоненты информационных систем',
        icon: 'architecture',
        color: Colors.purple.value,
        content: '''
# Архитектура информационных систем

## Многоуровневая архитектура:
- **Презентационный уровень** - пользовательский интерфейс
- **Бизнес-логика** - обработка данных и правила
- **Уровень данных** - хранение и доступ к данным

## Клиент-серверная архитектура:
- Толстый клиент vs тонкий клиент
- Серверы приложений
- Балансировка нагрузки
- Кластеризация

## Сервис-ориентированная архитектура (SOA):
- Веб-сервисы
- REST API
- Микросервисы
- Оркестрация сервисов

## Облачная архитектура:
- IaaS, PaaS, SaaS модели
- Виртуализация
- Контейнеризация
- Автомасштабирование

## Паттерны проектирования:
- MVC (Model-View-Controller)
- Repository pattern
- Factory pattern
- Observer pattern
''',
        isBookmarked: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Section(
        id: '5',
        title: 'Разработка ИС',
        description: 'Процессы создания информационных систем',
        icon: 'development',
        color: Colors.red.value,
        content: '''
# Разработка информационных систем

## Методологии разработки:
- **Waterfall** - каскадная модель
- **Agile** - гибкая разработка
- **Scrum** - фреймворк Agile
- **Kanban** - визуальное управление

## Этапы разработки:
1. **Анализ требований** - сбор и формализация
2. **Проектирование** - архитектура и интерфейсы
3. **Реализация** - программирование
4. **Тестирование** - проверка качества
5. **Внедрение** - установка у пользователя
6. **Сопровождение** - поддержка и развитие

## Инструменты разработки:
- Системы контроля версий (Git)
- CI/CD пайплайны
- Контейнеризация (Docker)
- Оркестрация (Kubernetes)

## Управление проектами:
- Планирование сроков
- Управление рисками
- Контроль качества
- Документирование
''',
        isBookmarked: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Section(
        id: '6',
        title: 'Безопасность ИС',
        description: 'Защита информационных систем и данных',
        icon: 'security',
        color: Colors.amber.value,
        content: '''
# Безопасность информационных систем

## Угрозы безопасности:
- Неавторизованный доступ
- Утечки данных
- DDoS атаки
- Вредоносное ПО
- Социальная инженерия

## Методы защиты:
- **Аутентификация** - проверка подлинности
- **Авторизация** - контроль доступа
- **Шифрование** - защита данных
- **Резервное копирование** - восстановление

## Политики безопасности:
- Управление доступом
- Аудит и мониторинг
- Реагирование на инциденты
- Обучение пользователей

## Стандарты безопасности:
- ISO 27001
- PCI DSS
- GDPR
- ФЗ-152 о персональных данных
''',
        isBookmarked: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Section(
        id: '7',
        title: 'Облачные ИС',
        description: 'Информационные системы в облачной среде',
        icon: 'cloud',
        color: Colors.cyan.value,
        content: '''
# Облачные информационные системы

## Модели развертывания:
- **Публичное облако** - AWS, Azure, GCP
- **Частное облако** - корпоративная инфраструктура
- **Гибридное облако** - комбинация подходов

## Сервисные модели:
- **IaaS** - инфраструктура как услуга
- **PaaS** - платформа как услуга
- **SaaS** - программное обеспечение как услуга

## Преимущества облачных ИС:
- Масштабируемость
- Экономическая эффективность
- Высокая доступность
- Гибкость развертывания

## Провайдеры облачных услуг:
- **Amazon Web Services** - лидер рынка
- **Microsoft Azure** - интеграция с продуктами Microsoft
- **Google Cloud Platform** - AI/ML возможности
- **Yandex Cloud** - российское решение
''',
        isBookmarked: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Section(
        id: '8',
        title: 'ERP системы',
        description: 'Системы планирования ресурсов предприятия',
        icon: 'erp',
        color: Colors.indigo.value,
        content: '''
# ERP системы

## Определение ERP:
ERP (Enterprise Resource Planning) - система для интегрированного управления всеми ресурсами предприятия.

## Основные модули:
- **Финансы** - учет, отчетность, бюджетирование
- **Логистика** - управление цепочками поставок
- **Производство** - планирование, контроль качества
- **HR** - управление персоналом
- **CRM** - управление отношениями с клиентами

## Популярные ERP системы:
- **SAP ERP** - мировой лидер
- **Oracle E-Business Suite**
- **Microsoft Dynamics 365**
- **1C:Предприятие** - российское решение

## Внедрение ERP:
- Анализ бизнес-процессов
- Настройка и кастомизация
- Миграция данных
- Обучение пользователей
- Техническая поддержка

## Тенденции:
- Облачные ERP
- Мобильный доступ
- AI и аналитика
- IoT интеграция
''',
        isBookmarked: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  static Future<void> saveSections(List<Section> sections) async {
    final jsonList = sections.map((section) => section.toJson()).toList();
    await _prefs?.setString('sections', json.encode(jsonList));
  }

  static Future<void> updateSection(Section section) async {
    final sections = await loadSections();
    final index = sections.indexWhere((s) => s.id == section.id);
    if (index != -1) {
      sections[index] = section;
      await saveSections(sections);
    }
  }

  static Future<void> toggleBookmark(String sectionId, bool isBookmarked) async {
    final sections = await loadSections();
    final index = sections.indexWhere((s) => s.id == sectionId);
    if (index != -1) {
      sections[index] = sections[index].copyWith(isBookmarked: isBookmarked);
      await saveSections(sections);
    }
  }
}

// Остальной код (HomePage, SectionDetailScreen, EditSectionScreen, CustomSearchDelegate)
// остается без изменений, так как он уже хорошо написан и будет работать с новыми разделами

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Section> _sections = [];
  List<Section> _filteredSections = [];
  bool _isLoading = true;
  bool _showBookmarksOnly = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await DataService.init();
    _loadSections();
  }

  Future<void> _loadSections() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final sections = await DataService.loadSections();
      setState(() {
        _sections = sections;
        _filteredSections = sections;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackbar('Ошибка загрузки данных: $e');
    }
  }

  void _searchSections(String query) {
    setState(() {
      _filteredSections = _sections.where((section) {
        final searchLower = query.toLowerCase();
        return section.title.toLowerCase().contains(searchLower) ||
            section.description.toLowerCase().contains(searchLower) ||
            section.content.toLowerCase().contains(searchLower);
      }).toList();

      if (_showBookmarksOnly) {
        _filteredSections = _filteredSections.where((s) => s.isBookmarked).toList();
      }
    });
  }

  void _toggleBookmarksFilter() {
    setState(() {
      _showBookmarksOnly = !_showBookmarksOnly;
      if (_showBookmarksOnly) {
        _filteredSections = _sections.where((s) => s.isBookmarked).toList();
      } else {
        _filteredSections = List.from(_sections);
      }
    });
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _navigateToSectionDetail(Section section) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SectionDetailScreen(
          section: section,
          onSectionUpdated: (updatedSection) {
            _updateSectionInList(updatedSection);
          },
        ),
      ),
    );
  }

  void _navigateToEditSection(Section section) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSectionScreen(
          section: section,
          onSectionUpdated: (updatedSection) {
            _updateSectionInList(updatedSection);
          },
        ),
      ),
    );
  }

  void _updateSectionInList(Section updatedSection) {
    setState(() {
      final index = _sections.indexWhere((s) => s.id == updatedSection.id);
      if (index != -1) {
        _sections[index] = updatedSection;
        _filteredSections = List.from(_sections);

        if (_showBookmarksOnly) {
          _filteredSections = _filteredSections.where((s) => s.isBookmarked).toList();
        }
      }
    });
  }

  Future<void> _toggleBookmark(Section section) async {
    try {
      final updatedSection = section.copyWith(isBookmarked: !section.isBookmarked);
      await DataService.toggleBookmark(section.id, updatedSection.isBookmarked);
      _updateSectionInList(updatedSection);

      _showSuccessSnackbar(
          updatedSection.isBookmarked
              ? 'Добавлено в закладки'
              : 'Удалено из закладок'
      );
    } catch (e) {
      _showErrorSnackbar('Ошибка обновления закладки: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Справочник по ИС'),
        actions: [
          IconButton(
            icon: Icon(_showBookmarksOnly ? Icons.bookmark : Icons.bookmark_border),
            onPressed: _toggleBookmarksFilter,
            tooltip: 'Показать только закладки',
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(_sections),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _filteredSections.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              _showBookmarksOnly
                  ? 'Нет закладок'
                  : 'Ничего не найдено',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: _filteredSections.length,
        itemBuilder: (context, index) {
          final section = _filteredSections[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: section.colorValue.withOpacity(0.2),
                child: Icon(
                  section.iconData,
                  color: section.colorValue,
                  size: 24,
                ),
              ),
              title: Text(
                section.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                section.description,
                style: TextStyle(fontSize: 14),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      section.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: section.isBookmarked
                          ? Colors.amber
                          : Colors.grey,
                    ),
                    onPressed: () => _toggleBookmark(section),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              onTap: () => _navigateToSectionDetail(section),
              onLongPress: () => _navigateToEditSection(section),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadSections,
        child: Icon(Icons.refresh),
        tooltip: 'Обновить данные',
      ),
    );
  }
}

class SectionDetailScreen extends StatelessWidget {
  final Section section;
  final Function(Section) onSectionUpdated;

  const SectionDetailScreen({
    super.key,
    required this.section,
    required this.onSectionUpdated,
  });

  Future<void> _toggleBookmark() async {
    try {
      final updatedSection = section.copyWith(isBookmarked: !section.isBookmarked);
      await DataService.toggleBookmark(section.id, updatedSection.isBookmarked);
      onSectionUpdated(updatedSection);
    } catch (e) {
      print('Ошибка обновления закладки: $e');
    }
  }

  Future<void> _shareContent() async {
    try {
      await Share.share(
        '${section.title}\n\n${section.description}\n\n${section.content}',
        subject: section.title,
      );
    } catch (e) {
      print('Ошибка при попытке поделиться: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(section.title),
        backgroundColor: section.colorValue,
        actions: [
          IconButton(
            icon: Icon(
              section.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: section.isBookmarked ? Colors.amber : Colors.white,
            ),
            onPressed: _toggleBookmark,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareContent,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: section.colorValue.withOpacity(0.2),
                    radius: 40,
                    child: Icon(
                      section.iconData,
                      color: section.colorValue,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    section.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    section.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 16),

            Text(
              'Содержание:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              child: Text(
                section.content,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: _shareContent,
                  icon: Icon(Icons.share),
                  label: Text('Поделиться'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: section.colorValue,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _toggleBookmark,
                  icon: Icon(
                    section.isBookmarked ? Icons.bookmark_remove : Icons.bookmark_add,
                  ),
                  label: Text(section.isBookmarked ? 'Удалить' : 'В закладки'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: section.colorValue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EditSectionScreen extends StatefulWidget {
  final Section section;
  final Function(Section) onSectionUpdated;

  const EditSectionScreen({
    super.key,
    required this.section,
    required this.onSectionUpdated,
  });

  @override
  _EditSectionScreenState createState() => _EditSectionScreenState();
}

class _EditSectionScreenState extends State<EditSectionScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.section.title);
    _descriptionController = TextEditingController(text: widget.section.description);
    _contentController = TextEditingController(text: widget.section.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Название не может быть пустым')),
      );
      return;
    }

    try {
      final updatedSection = widget.section.copyWith(
        title: _titleController.text,
        description: _descriptionController.text,
        content: _contentController.text,
        updatedAt: DateTime.now(),
      );

      await DataService.updateSection(updatedSection);
      widget.onSectionUpdated(updatedSection);

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Изменения сохранены')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка сохранения: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать раздел'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Название раздела',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Описание',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Содержание',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Section> sections;

  CustomSearchDelegate(this.sections);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final List<Section> suggestionList = query.isEmpty
        ? sections
        : sections.where((section) {
      final titleLower = section.title.toLowerCase();
      final descriptionLower = section.description.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          descriptionLower.contains(searchLower);
    }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final section = suggestionList[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: section.colorValue.withOpacity(0.2),
            child: Icon(section.iconData, color: section.colorValue),
          ),
          title: Text(section.title),
          subtitle: Text(section.description),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SectionDetailScreen(
                  section: section,
                  onSectionUpdated: (updatedSection) {},
                ),
              ),
            );
            close(context, section);
          },
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: theme.appBarTheme.foregroundColor),
        border: InputBorder.none,
      ),
    );
  }
}
