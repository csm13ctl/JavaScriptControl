
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Объект.Ссылка.Пустая() 
		И Параметры.Свойство("Файл") 
		И Параметры.Файл.Количество() Тогда
			
		ПомещаемыйФайл 			= Параметры.Файл;
		АдресФайла 				= ПомещаемыйФайл.Адрес;
		Файл 					= ПомещаемыйФайл.СсылкаНаФайл.Файл;
		Объект.ИмяФайла 		= Файл.Имя;
		Объект.ПолноеИмяФайла 	= Файл.ПолноеИмя;
		Объект.Наименование 	= Файл.ИмяБезРасширения;
		
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если ПустаяСтрока(Объект.ИмяФайла) Тогда
		Описание = Новый ОписаниеОповещения("ЗакрытьФорму", ЭтаФорма);
		ПоказатьПредупреждение(Описание
		, "Открытие формы файла возможно только при загрузке,
		|либо уже существующего элемента");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьФорму(ДополнительныеПараметры) Экспорт
	Закрыть();
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	Если Не ПустаяСтрока(АдресФайла) Тогда
		ТекущийОбъект.Хранилище = Новый ХранилищеЗначения(ПолучитьИзВременногоХранилища(АдресФайла));
	КонецЕсли;
КонецПроцедуры
