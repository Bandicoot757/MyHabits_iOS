#  MyHabits
## Cписок изменений

## beta 4

* Переработана логика habitDetailViewController: теперь показываются даты с момента установки приложения
* Добавлены галочки на затреканных датах ячеек habitDetailViewController
* Даты больше не идут в обратной последовательности
* Переписана логика подсчета сколько раз подряд была выполнена привычка на HabitsViewController


## beta 3 

* Улучшена логика атрибутов в HabitViewController (метод datePickerDateSelected())
* После изменения имени привычки на экране HabitDetailViewController теперь обновляется заголовок

## beta 2 

* Убран пустой ViewController
* Изменена логика NavigationController'ов
* Исправлены тексты в заголовках
* Изменен вывод дат привычек на экране выбранной привычки
* Заголовок страницы редактирования изменен на "править"
* При удалении привычки заголовок алерта выводит название удаляемой привычки
* При выборе цвета контроллер больше не закрывается автоматически
* Изменена логика атрибутов текста
* Прочие минорные изменения

## Известные проблемы:

* При переходе с HabitDetailViewController на HabitsViewController не применяется largeTitle к navigationBar




