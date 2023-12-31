# Changan UNI - K Android FUN

## Для начала

Все, что написано ниже, проделывайте на свой страх и риск. Я не буду нести ответсвенность за то, что вы сами сделаете со
своим автомобилем.

## Инженерное меню

Запускаем приложение телефон

<p align="center">
  <img src="/assets/0-phone-0.png" width="85%"/>
</p>

Вводим номер `*#*#888` и нажимаем вызов

<p align="center">
  <img src="/assets/0-phone-2.png" width="85%"/>
</p>

Должен появится экран с вводом пароля. Набираем `369875`.

<p align="center">
  <img src="/assets/0-phone-3.png" width="85%"/>
</p>

Появится инженерное меню головного устройства. Все надписи будут на китайском.

## Включаем ADB

В инжеренром меню необходимо включить доступ к устройству с помощью `adb`. Для этого нажимаем кнопки как на экране ниже (что бы выключить `adb` нажимаем другую
кнопку).

<p align="center">
  <img src="/assets/1-menu-0.png" width="85%"/>
</p>

## Работа с adb

Что бы запустить `adb` вам необходимо для начало его установить на ваш ПК/ноут. У меня операционная система Arch Linux,
`adb` находится в пакете `extra/android-tools`. Устанавливается командой:

```sh
> yay -S android-tools # или packan -S ...
```

Как установить `adb` в других ОС я не знаю (гугл в помощь)

Давайте проверим увидел ли комп наш android через `adb`:

```sh
> adb devices
```

В ответ, если мы все сделали правильно, должны увидеть следующее:

```sh
List of devices attached
0123456789ABCDEF        device
```

Если это не так, то скорее всего что-то сделали неправильно. Можно попробовать перезагрузить Android, зажав кнопку
уменьшения громкости на руле в течении 10сек.

И так, `adb` у нас работает, можем им пользоваться.

Давайте попробуем получить shell-доступ к устройству. Для этого введем команду:

```sh
> adb shell
please input verify password:
```

В качестве пароля вводим `adb36987`, после чего оказываемся в командой строке. Работает! Пока закрое наш shell (ctrl-d
или команда `exit`)

Что бы получить root на устройстве достаточно ввести команду

```sh
> adb root
restarting adbd as root
```

Что бы Android разрешил писать и читать системные разделы ФС вводим следующую команду

```sh
> adb remount
remount succeeded
```

Теперь если мы снова зайдем в shell, то у нас будут root-права и права на чтение и запись в системные разделы такие как `/system`

с помощью `adb` мы можем запускать разные приложения на нашем головном устройстве, даже если они скрыты. Например:

```sh
> echo adb36987 | adb shell monkey -p com.android.settings -c android.intent.category.LAUNCHER 1
```

Данная команда откроет настройки Android системы

Мы также можем с помощью `adb` установить `apk` в систему. К сожалению `adb install name.apk` не работает. Но мы можем
вначале загрузить приложение в наш Android, а потом его проинсталировать. Давайте это сделаем.

Загрузка apk в устройство

```sh
> echo adb36987 | adb push FX_v9.0.1.2\(9012\).apk /data/media/0/Download/
```

Установка
```sh
> echo adb36987 | adb shell pm install -t /data/media/0/Download/FX_v9.0.1.2\(9012\).apk
```

~~К сожалению, приложение не появится в лаунчере, но~~ _(см. ниже)_ его можно будет запустить вручную, с помощью `adb`

```sh
> echo adb36987 | adb shell monkey -p nextapp.fx -c android.intent.category.LAUNCHER 1
```

В данном случае `nextapp.fx` - это `package name` установленного приложения. Что бы получить список всех установленных
приложений вводим команду:

```sh
> echo adb36987 | adb shell pm list packages
```

## Добавляем иконку установленного приложения в штатный лаунчер

Чтобы после установки приложение появилось в штатном лаунчере достаточно почистить кэш лаунчера и перезагрузить ГУ!

**:feelsgood: Но будь осторожен - после удаления установленного приложения необходимо снова почистить кэш лаунчера и перезагрузить ГУ.**

<!--
TODO: проверить и добавить картинок
TODO: проверить очистку кеша через `adb shell pm clear <launcher.package.name>`
-->

## Скрипты

Я постарался и написал для вас скрипты (только для linux!!!), что бы устанавливать и удалять приложения в changan было удобно.

**Используюйте на свой страх и риск!!!**

* `adbRootRemount.sh` - получаем рута и перемантируем файловую систему для возможности записи. Запуск скрипта необходим
    если нужно будет сделать скриншот или установить приложение.
* `adbTakeScreenshot.sh` - сделать скриншот экрана главного дисплей и сохранить его на компьютере
* `adbInstallApp.sh` - установить приложение с компьютера. Скрипт автоматом установит APK и почистит кэш лаунчера, что
    бы приложение появилось в лаунчере
* `adbList.sh` - покажет список всех установленных приложений в виде имени пакета. Данный скрипт понадобится, если вы
    захотите удалить приложение из системы, что бы узнать имя пакета приложения.
* `adbRemoveApp.sh` - удалить приложение из системы. Нужно знать имя пакета приложения. Скрипт так же почистит кжш
    лаунчера за вас.

## Убираем с экрана надпись голосового помощника

Данная процедура убирает только надпись на экране, сам же помощник будет работать.

Открываем настройки Android через `adb`, либо через пунк в инжеренром меню

<p align="center">
  <img src="/assets/1-menu-1.png" width="85%"/>
</p>

Идем в приложения, а дальше все приложения. Там находим нужное нам приложение с названием на китайском

<p align="center">
  <img src="/assets/2-voice-assistant-0.png" width="85%"/>
</p>

Ищем нужную нам настройку

<p align="center">
  <img src="/assets/2-voice-assistant-1.png" width="85%"/>
</p>

<p align="center">
  <img src="/assets/2-voice-assistant-2.png" width="85%"/>
</p>

И выключаем

<p align="center">
  <img src="/assets/2-voice-assistant-3.png" width="85%"/>
</p>

Готово!

## Список литературы

* [Zerocnx 1](https://github.com/Zerocnx/ChangAn-Raeton-UNIV-)
* [Zerocnx 2](https://github.com/Zerocnx/ChangAn-FeiYu_Wutong)
* [XDA](https://forum.xda-developers.com/t/changan-uni-t-2022-s202_ica_spm8666p1_64_car.4540235/)
* [Telegram канал Changan Community](https://t.me/my_smart_car)
* ~~[Telegram канал русскоязычного сообщества Changan UNI K](https://t.me/changan_uni_k)~~
