import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introspection_note_mvp/controller/introspection_list_screen_controller.dart';
import 'package:introspection_note_mvp/data/models/introspection_note.dart';
import 'package:introspection_note_mvp/data/models/modify_form_color_scheme.dart';
import 'package:introspection_note_mvp/util/util.dart';
import 'package:introspection_note_mvp/widget/introspection_card.dart';
import 'package:table_calendar/table_calendar.dart';

class IntrospectionListPage extends GetView<IntrospectionListScreenController> {
  const IntrospectionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final IntrospectionColor introspectionColor = getFormColorScheme(context);
    final bool isDarkTheme = checkIsDarkTheme(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('内省ノート'),
        actions: [
          IconButton(
            onPressed: controller.navigateToSettingsScreen,
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.navigateToCreateIntrospectionScreen,
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSwitchViewMode(controller),
                controller.isLoading
                    ? _buildLoading()
                    : controller.viewMode == ViewMode.list
                    ? _buildListView(
                      controller.notes,
                      controller.manipulatingNote,
                      introspectionColor,
                      (IntrospectionNote note) {
                        controller.edit(note);
                      },
                      (IntrospectionNote note) {
                        controller.delete(note);
                      },
                    )
                    : Expanded(child: _buildCalendarVIew(isDarkTheme)),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSwitchViewMode(IntrospectionListScreenController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            controller.changeViewMode(
              controller.viewMode == ViewMode.list
                  ? ViewMode.calendar
                  : ViewMode.list,
            );
          },
          icon: Icon(
            controller.viewMode == ViewMode.list
                ? Icons.list
                : Icons.calendar_today,
          ),
        ),
      ],
    );
  }

  Widget _buildListView(
    List<IntrospectionNote> notes,
    IntrospectionNote? manipulatingNote,
    IntrospectionColor introspectionColor,
    Function(IntrospectionNote note) onEdit,
    Function(IntrospectionNote note) onDelete,
  ) {
    return Expanded(
      child:
          notes.isNotEmpty
              ? ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: IntrospectionCard(
                      note: note,
                      introspectionColor: introspectionColor,
                      allowManipulation: manipulatingNote != note,
                      onEdit: () => onEdit(note),
                      onDelete: () => onDelete(note),
                    ),
                  );
                },
              )
              : const Center(
                child: Text(
                  '内省がまだありません。\n右下のボタンから追加してください。',
                  textAlign: TextAlign.center,
                ),
              ),
    );
  }

  Widget _buildCalendarVIew(bool isDarkTheme) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TableCalendar(
              focusedDay: controller.selectedDate,
              currentDay: controller.selectedDate,
              firstDay: DateTime.utc(2025, 3, 20),
              lastDay: DateTime.now(),
              eventLoader:
                  (day) =>
                      controller.notes
                          .where(
                            (note) =>
                                note.date.year == day.year &&
                                note.date.month == day.month &&
                                note.date.day == day.day,
                          )
                          .toList(),
              onDaySelected: (selectedDay, focusedDay) {
                controller.changeSelectedDate(selectedDay);
              },
              calendarStyle: CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: isDarkTheme ? Colors.white : Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              locale: 'ja_JP',
            ),
          ),
          // Expandedを削除し、ListView.builderにshrinkWrapを適用
          controller.filteredNotes.isEmpty
              ? Container(
                height: 100, // 空の場合の最小高さを指定
                alignment: Alignment.center,
                child: const Text('内省がありません'),
              )
              : ListView.builder(
                shrinkWrap: true, // これが重要
                physics: const NeverScrollableScrollPhysics(), // 親のスクロールを使用
                itemCount: controller.filteredNotes.length,
                itemBuilder: (context, index) {
                  final note = controller.filteredNotes[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: IntrospectionCard(
                      note: note,
                      introspectionColor: getFormColorScheme(context),
                      allowManipulation: controller.manipulatingNote != note,
                      onEdit: () => controller.edit(note),
                      onDelete: () => controller.delete(note),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }
}
