
// <Описание функции>
//
// Параметры:
//  <Параметр1>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//  <Параметр2>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//
// Возвращаемое значение:
//   <Тип.Вид>   - <описание возвращаемого значения>
//
Функция УстановкаПараметровКлиента(Обработчики) Экспорт 

	Результат = Новый Соответствие;
	
	Для Каждого текОбработчик Из Обработчики Цикл
		Результат.Вставить(текОбработчик.Ключ, Вычислить(СтрШаблон("%1()", текОбработчик.Значение)));
	КонецЦикла;
	
	Возврат Результат
	
КонецФункции // УстановкаПараметровКлиента()


// <Описание процедуры>
//
// Параметры:
//  <Параметр1>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//  <Параметр2>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//
Процедура ОбработкаСобытияЗаписьЖурналаРегистрации(Событие) Экспорт 

	Сообщение = Событие.Получить("message");
	Если Сообщение = Неопределено Тогда
		Возврат;
	Иначе
		Сообщение = Сообщение.value;
	КонецЕсли;
	
	ИмяСобытия = Событие.Получить("eventName");
	Если ИмяСобытия <> Неопределено Тогда
		ИмяСобытия = ИмяСобытия.value;
	КонецЕсли;
		
	Уровень = Событие.Получить("level");
	Если Уровень = Неопределено Тогда
		Уровень = УровеньЖурналаРегистрации.Информация;		
	Иначе
		Уровень = СоответствиеУровнейЗаписиЖурнала().Получить(Уровень.value);
		Если Уровень = Неопределено Тогда
			Уровень = УровеньЖурналаРегистрации.Информация;	
		КонецЕсли;
	КонецЕсли;
	
	ЗаписьЖурнала(Сообщение, ИмяСобытия, Уровень);

КонецПроцедуры // ОбработкаСобытияЗаписьЖурналаРегистрации()


// <Описание функции>
//
// Параметры:
//  <Параметр1>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//  <Параметр2>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//
// Возвращаемое значение:
//   <Тип.Вид>   - <описание возвращаемого значения>
//
Функция СоответствиеУровнейЗаписиЖурнала()

	Результат = Новый Соответствие;
	Результат.Вставить("info", УровеньЖурналаРегистрации.Информация);
	Результат.Вставить("Информация", УровеньЖурналаРегистрации.Информация);
	Результат.Вставить("error", УровеньЖурналаРегистрации.Информация);
	Результат.Вставить("Ошибка", УровеньЖурналаРегистрации.Информация);
	Результат.Вставить("warning", УровеньЖурналаРегистрации.Информация);
	Результат.Вставить("Предупреждение", УровеньЖурналаРегистрации.Информация);
	Результат.Вставить("Note", УровеньЖурналаРегистрации.Информация);
	Результат.Вставить("Примечание", УровеньЖурналаРегистрации.Информация);

	Возврат Результат;

КонецФункции // СоответствиеУровнейЗаписиЖурнала()

// <Описание процедуры>
//
// Параметры:
//  <Параметр1>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//  <Параметр2>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//
Процедура ЗаписьЖурнала(Сообщение, ИмяСобытия = "Информация", Уровень = Неопределено)

	Если Уровень = Неопределено Тогда
		Уровень = УровеньЖурналаРегистрации.Информация;
	КонецЕсли;
	Если ПустаяСтрока(ИмяСобытия) Тогда
		ИмяСобытия = "Информация";
	КонецЕсли;
	ЗаписьЖурналаРегистрации(СтрШаблон("ПодключаемыеСкрипты.%1", ИмяСобытия), Уровень,,,Сообщение);	

КонецПроцедуры // ЗаписьЖурнала()




