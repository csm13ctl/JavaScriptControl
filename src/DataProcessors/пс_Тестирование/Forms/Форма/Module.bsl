
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	пс_Скрипты.ПодключитьРасширенныеСкрипты(Элементы.ХТМЛ);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	//
	пс_СкриптыКлиент.УстановитьПолеХТМЛПоУмолчанию(Элементы.ХТМЛ);
КонецПроцедуры

&НаКлиенте
Процедура ХТМЛПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	пс_СкриптыКлиент.ПриНажатии(ДанныеСобытия, Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьКомандуКонсоли(Команда)
	//@skip-warning
	Результат = пс_СкриптыКлиент.ВыполнитьКоманду(Консоль);
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьКонтекст(Команда)
	ГлобальныйКонтекст = пс_СкриптыКлиент.ПолучитьКонтекст(,Истина);
	УзелДерева = ДеревоКонтекста.ПолучитьЭлементы();
	УзелДерева.Очистить();
	Для Каждого текЭлемент Из ГлобальныйКонтекст Цикл
		ДобавляемыйОбъект = УзелДерева.Добавить();
		ЗаполнитьЗначенияСвойств(ДобавляемыйОбъект,текЭлемент.Значение);
		ДобавляемыйОбъект.ПолучитьЭлементы().Добавить();
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ДеревоКонтекстаПередРазворачиванием(Элемент, Строка, Отказ)
	СтрокаКонтекста = ДеревоКонтекста.НайтиПоИдентификатору(Строка);
	ПутьКОбъекту = ПолучитьПутьКДанным(СтрокаКонтекста);
	ИсследуемыйОбъект = пс_СкриптыКлиент.ВыполнитьКоманду(ПутьКОбъекту);
	РазворачиваемыйУзел = СтрокаКонтекста.ПолучитьЭлементы();
	РазворачиваемыйУзел.Очистить();
	ДоступныйКонтекстОбъекта = пс_СкриптыКлиент.ПолучитьКонтекст(ИсследуемыйОбъект, Истина);
	Для Каждого текСвойство Из ДоступныйКонтекстОбъекта Цикл
		ДобавляемыйУзел = РазворачиваемыйУзел.Добавить();
		ЗаполнитьЗначенияСвойств(ДобавляемыйУзел, текСвойство.Значение);
		ДобавляемыйУзел.ПолучитьЭлементы().Добавить();
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Функция ПолучитьПутьКДанным(ЭлементКонтекста, ПутьКДанным = "")

	Родитель = ЭлементКонтекста.ПолучитьРодителя();
	Если Родитель = Неопределено Тогда
		Возврат ЭлементКонтекста.name + ПутьКДанным;
	КонецЕсли;
	ЭтоИндекс = Ложь;
	Попытка
		//@skip-warning
		ф=Число(ЭлементКонтекста.name);
		ЭтоИндекс = Истина;
	Исключение	
	КонецПопытки;
	Если ЭтоИндекс Тогда
		Шаблон = "[%1]%2";
	Иначе
		Шаблон = ".%1%2";
	КонецЕсли;
	Возврат ПолучитьПутьКДанным(Родитель, СтрШаблон(Шаблон, ЭлементКонтекста.name, ПутьКДанным)); 
	
КонецФункции // ПолучитьПутьКДанным()

&НаКлиенте
Процедура КомандаВыполнитьМетод(Команда)
	Если Элементы.ДеревоКонтекста.ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ЭлементДереваКонтекста = ДеревоКонтекста.НайтиПоИдентификатору(Элементы.ДеревоКонтекста.ТекущаяСтрока);
	Если Не ЭлементДереваКонтекста.type = "function" Тогда
		Возврат;
	КонецЕсли;
	КонтекстВыполнения = Null;
	Родитель = ЭлементДереваКонтекста.ПолучитьРодителя();
	Если Родитель <> Неопределено Тогда
		ПутьКОбъекту = ПолучитьПутьКДанным(Родитель);
		КонтекстВыполнения = пс_СкриптыКлиент.ВыполнитьКоманду(ПутьКОбъекту);
	КонецЕсли;
	//@skip-warning
	Рез = пс_СкриптыКлиент.ВыполнитьМетодОбъекта(КонтекстВыполнения, ЭлементДереваКонтекста.name); 
КонецПроцедуры

&НаКлиенте
Процедура Ожидания(Команда)
	//@skip-warning
	Результат = пс_СкриптыКлиент.ПолучитьАктивныеОбработчикиОжидания();
КонецПроцедуры

&НаКлиенте
Процедура Повторения(Команда)
	//@skip-warning
	Результат = пс_СкриптыКлиент.ПолучитьАктивныеОбработчикиПовторения();
КонецПроцедуры

&НаКлиенте
Процедура Подписки(Команда)
	//@skip-warning
	Результат = пс_СкриптыКлиент.ПолучитьАктивныеПодпискиНаСобытия();
КонецПроцедуры

&НаКлиенте
Процедура КомандаНовыйВебСокет(Команда)
	ОписаниеЗакрыт = Новый ОписаниеОповещения("СокетЗакрыт", ЭтаФорма);
	ОписаниеОткрыт = Новый ОписаниеОповещения("СокетОткрыт", ЭтаФорма);
	ОписаниеСообщение = Новый ОписаниеОповещения("СокетСообщение", ЭтаФорма);
	ОписаниеОшибка = Новый ОписаниеОповещения("СокетОшибка", ЭтаФорма);
	пс_СкриптыКлиент.НовыйВебСокет("wss://echo.websocket.org",,"f",ОписаниеОткрыт
		,ОписаниеОшибка, ОписаниеСообщение, ОписаниеЗакрыт);
//	пс_СкриптыКлиент.СокетДобавитьОбработчикЗакрытия(Сокет, ОписаниеЗакрыт);
//	пс_СкриптыКлиент.СокетДобавитьОбработчикСоединения(Сокет, ОписаниеОткрыт);
//	пс_СкриптыКлиент.СокетДобавитьОбработчикСообщения(Сокет, ОписаниеСообщение);
//	пс_СкриптыКлиент.СокетДобавитьОбработчикОшибки(Сокет, ОписаниеОшибка);
КонецПроцедуры


// <Описание процедуры>
//
// Параметры:
//  <Параметр1>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//  <Параметр2>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//
&НаКлиенте
Процедура СокетЗакрыт(ДанныеСобытия, ДополнительныеПараметры) Экспорт 

	Сообщить("Сокет закрыт!");

КонецПроцедуры // СокетЗакрыт()


// <Описание процедуры>
//
// Параметры:
//  <Параметр1>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//  <Параметр2>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//
&НаКлиенте
Процедура СокетОткрыт(ДанныеСобытия, ДополнительныеПараметры) Экспорт 

	Сообщить("Сокет открыт!");

КонецПроцедуры // СокетОткрыт()


// <Описание процедуры>
//
// Параметры:
//  <Параметр1>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//  <Параметр2>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//
&НаКлиенте
Процедура СокетСообщение(ДанныеСобытия, ДополнительныеПараметры) Экспорт 

	Сообщить(СтрШаблон("Сокет сообщение: %1", ДанныеСобытия.data));

КонецПроцедуры // СокетСообщение()


// <Описание процедуры>
//
// Параметры:
//  <Параметр1>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//  <Параметр2>  - <Тип.Вид> - <описание параметра>
//                 <продолжение описания параметра>
//
&НаКлиенте
Процедура СокетОшибка(ДанныеСобытия, ДополнительныеПараметры) Экспорт 

	Сообщить("Сокет ошибка!");

КонецПроцедуры // СокетОшибка()



