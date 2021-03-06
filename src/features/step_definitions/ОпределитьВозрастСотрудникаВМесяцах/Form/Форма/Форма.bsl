﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЕстьДатаРожденияРавная(Парам01)","ЕстьДатаРожденияРавная","Допустим Есть Дата рождения равная 01.07.2016");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЕстьДатаРасчетаРавная(Парам01)","ЕстьДатаРасчетаРавная","И Есть дата расчета равная 01.08.2016");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"РезультатРасчетаБудетРавен(Парам01)","РезультатРасчетаБудетРавен","Тогда  Результат расчета будет равен 1");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//Допустим Есть Дата рождения равная 01.07.2016
//@ЕстьДатаРожденияРавная(Парам01)
Процедура ЕстьДатаРожденияРавная(ДатаРождения) Экспорт
	Контекст.Вставить("ДатаРождения",ДатаРождения);
КонецПроцедуры

&НаКлиенте
//И Есть дата расчета равная 01.08.2016
//@ЕстьДатаРасчетаРавная(Парам01)
Процедура ЕстьДатаРасчетаРавная(ДатаРасчета) Экспорт
	Контекст.Вставить("ДатаРасчета",ДатаРасчета);
КонецПроцедуры

&НаКлиенте
//Тогда  Результат расчета будет равен 1
//@РезультатРасчетаБудетРавен(Парам01)
Процедура РезультатРасчетаБудетРавен(ОжидаемыйРезультат) Экспорт
	Результат = ОбщийМодуль1.ПолучитьВозрастСотрудникаВМесяцах(Контекст.ДатаРождения,Контекст.ДатаРасчета);
	Если Результат <> ОжидаемыйРезультат Тогда
		ВызватьИсключение("Результат не верен");
	КонецЕсли;
КонецПроцедуры

//окончание текста модуля