# Bluetooth Data Exchange App
Dieses Repository enthält Informationen und Code aus dem BOGY (Berufsorientierung für Gymnasien), das in Kooperation zwischen dem Leibniz Gymnasium in Rottweil (https://www.lg-rw.de/) und der Firma Mitutoyo CTL Germany GmbH (https://www.mitutoyo-ctl.de/) im Frühjahr 2024 stattfand.

Es handelt sich um ein erweitertes Praktikum. Das bedeutet, dass es neben der üblichen Praktikums-Woche noch sechs vorbereitende Nachmittage gibt. An diesen Nachmittagen bringen wir den Schülern die Grundlagen bei, damit in der Praktikumswoche auch ein sichtbares Produkt entstehen kann.

## BOGY Woche, Dienstag 19.3.2024
Hier der Link zum Beispielcode (C++) wie man die DateTime Werte umrechnen kann:
https://godbolt.org/z/K453oPdov

Bluetooth Gatt-XML: https://github.com/oesmith/gatt-xml/blob/master/org.bluetooth.characteristic.date_time.xml

## BOGY Woche, Montag 18.3.2024

Wir haben nochmal das Thema Objektorientierung wiederholt, weil es bei Flutter so wichtig ist.

Danach haben wir die ersten Schritte mit [Flutter (Powerpoint)](doc/Flutter.pptx) gemacht.

## Nachmittag 6, Mittwoch 13.3.2024

Wir haben die [Dart (Powerpoint)](doc/Dart.pptx) abgeschlossen. Das wichtigste Thema dabei war sicherlich die Objektorientierung. Die wird uns das BOGY über ständig begleiten.

Da noch ein wenig Zeit übrig war, haben wir uns zudem noch ein wenig den Aufbau des Flutter Demo Projekts in Android Studio angeschaut, um eine bessere Vorstellung davon zu bekommen, wie sich eine Smartphone-App mit Flutter aufbauen lässt. 
Zuletzt haben wir noch probiert, die gesehene Struktur anhand eines kleinen Beispiels selbst zu programmieren.

## Nachmittag 5, Mittwoch 6.3.2024
Auch an diesem Nachmittag haben wir weiter mit der [Dart (Powerpoint)](doc/Dart.pptx) gearbeitet. Neu waren:

- Listen
- Maps
- Methoden
- Funktionen
- Named Arguments
- Scope
- Callbacks

Wir sind mit allen behandelten Themen fertig geworden und steigen nächste Woche mit Lambdas ein. Wir sind bis einschließlich Folie 70 gekommen.

## Nachmittag 4, Mittwoch 28.2.2024

Wir haben mit der [Dart (Powerpoint)](doc/Dart.pptx) weitergemacht. Neu waren:

- Strings
- Templates
- Schleifen (```for``` und ```while```)
- Wahrheitswerte
- Verzweigungen

Die Idee von Listen haben wir am Ende noch kurz angesprochen und werden mit dem Thema Listen am nächsten Mittwoch wieder einsteigen. Wir kamen bis einschließlich Folie 40.

## Nachmittag 3, Mittwoch 21.2.2024

Wir haben heute die Entwicklungsumgebung [Android Studio (Powerpoint)](doc/AndroidStudio.pptx) installiert. Das ist gar nicht so trivial, da es mehrere Komponenten gibt:

* Amazon Corretto, eine JRE (Java Runtime Environment) als Voraussetzung, dass Android Studio überhaupt läuft
* Android Studio selbst
* SDKs und Plugins für Android Studio
* den Emulator für Android-Geräte auf Windows
* Flutter als Framework für plattformunabhängige Apps

Nachdem uns diese Installation fast den gesamten Nachmittag gekostet hat, konnten wir noch mit [Dart (Powerpoint)](doc/Dart.pptx) beginnen und tatsächlich noch ein paar Befehle programmieren. Wir sind bis zur Aufgabe auf Folie 20 gekommen.

## Nachmittag 2, Mittwoch 7.2.2024

Wir haben uns heute mit der Programmierung des ESP32, insbesondere der Bluetooth-Anbindung beschäftigt. Den Code dazu haben wir in [esp_32_tutorials](esp_32_tutorials) abgelegt.

Das lief leider nicht ganz so gut, wie erwartet. Da das Thema BLE (Bluetooth Low Energy) auch für uns noch neu ist, werden wir uns das mal anschauen und fertigstellen. Nächstes Mal beginnen wir daher mit Android Studio.

## Nachmittag 1, Mittwoch 31.1.2024

Wir haben uns das Gebäude angeschaut, damit sich die Schüler auch zurechtfinden. Mit Hilfe der [Firmenpräsentation (Powerpoint)](doc/Firmenpräsentation.pptx) haben wir einen Überblick über den Aufbau der Firma und deren Produkte erhalten. Auch der Ablauf des Studiums wurde besprochen. Da unsere Partner-Hochschule die DHBW in Stuttgart ist,   haben wir in Stuttgart eine [Studentenwohnung (Powerpoint)](doc/Studentenwohnung.pptx) gemietet, die wir den Studenten zur Verfügung stellen.

Wir haben ganz kurz besprochen, was wir programmieren:

* einen Microcontroller (Typ ESP32), der Daten von einem Temperatursensor per Bluetooth BLE liefert
* eine Smartphone App, die diese Daten empfängt und darstellt

Wir haben darüber hinaus einige Ideen gesammelt, welche Features die App noch haben könnte:

* 

Weiterhin haben wir besprochen, wie man sich am Laptop und am WLAN anmeldet. Wir haben Discord Accounts eingerichtet und sind dem Kanal für das BOGY beigetreten. Wir haben Github Accounts angelegt und mit diesem Repository verknüpft. Außerdem haben wir die [Arduino IDE](https://www.arduino.cc/en/software) und [Visual Studio Code](https://code.visualstudio.com/download) installilert, mit denen wir den Microcontroller programmieren möchten, der uns die Daten per Bluetooth liefern soll.

