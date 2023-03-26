Представлет собой попытку создания простого и сравнительно универсального средства для просмотра онлайн-видео и новостных лент youtube в плеере, плюс скачивания видеофайлов на диск. Под "простым и универсальным" понимается минимальная привязка к браузеру, портативность и возможность подключения собственных средств.

Выкладывается в двух вариантах: 

- Базовый - предполагает работу только с браузером, включает в себя MPC-BE в качестве плеера (может быть заменен в настройках) и youtube-dl как средство закачки и альтернативный интернет-движок.  
- RSS-вариант включает в себя еще и QuiteRSS, лучший из имеющихся сейчас бесплатных программных вьюверов RSS, и позволяет просматривать видео и скачивать ролики из новостных лент youtube. Все возможности базовой версии сохранены, чтобы превратить второй вариант в первый достаточно просто удалить папку QuiteRSS.

[TOC]



# Проигрывание видео из браузера в плеере

При запуске программы появляется значок программы в трее. Он имеет контекстное меню для выполнения наиболее необходимых действий. Двойной клик по нему открывает плеер (в RSS-версии будет запускаться QuiteRSS). 
“Из коробки” программа позволяет открывать в произвольном браузере видео с оригинальных страниц, на которых видео и выложено (youtube, vimeo, tvkultura и пр.).

# Горячие клавиши в браузере

- Shift+Enter - открытие видео в плеере
- Ctrl+Shift+Enter - открытие меню программы (о чем ниже)
- Ctrl+Win+U, Ctrl+Win+клик средней кнопкой - открытие url из буфера обмена 
- Ctrl+Win+M или Ctrl+Win+Alt+средний клик - открытие меню программы для скопированной в буфер ссылки (другой вариант для последних двух пунктов - использовать контекстное меню иконки в трее)

Если установить расширения [Copy Link Address](https://chrome.google.com/webstore/detail/copy-link-address/kdejdkdjdoabfihpcjmgjebcpfbhepmh) для Chrome (в Opera надо поставить до этого [Install Chrome Extensions](https://addons.opera.com/ru/extensions/details/install-chrome-extensions/ )) или [Fast Copy Links](https://addons.mozilla.org/en-US/firefox/addon/fast-copy-links/?src=search) для Firefox, позволяющие копировать адрес ссылки по *Ctrl+C*, можно будет открывать ссылки на страницы с видео (ссылки из поиска, плитки youtube, встроенное  в страницы видео по клику на ссылке в верхнем левом углу), используя следующие сочетания:

- Shift+клик средней кнопкой мыши по ссылке - проигрывание ее в плеере
- Ctrl+Shift+клик средней кнопкой мыши по ссылке - открытие меню

Следует иметь ввиду, что если вы щелкаете по пустому месту, и копирование адреса не удается, будет скопирован адрес страницы и совершена попытка ее открытия, т. е. этими сочетаниями можно пользоваться и вместо предыдущих. В настройках есть опция подсветки меню в случае копирования ссылки, а не адреса страницы (работает не со всеми браузерами).

На ноутбуке, где нет средней кнопки, надо навести курсор мыши на ссылку и нажать Shift+Enter или Ctrl+Shift+Enter. 

На планшете используется такой трюк: открываем виртуальную клавиатуру, жмем на ссылку достаточно долго до появления выделения и контекстного меню. Не закрывая меню (оно закрывается автоматически), жмем Shift+Enter или Ctrl+Shift+Enter (не работает на страницах youtube). В худшем случае придется перейти на основную страницу видео и пользоваться сочетаниями клавиш уже там. Другой вариант - копировать ссылку и открывать ее по горячей клавише или из меню иконки в трее.

Использование программы много удобнее при выключении автовоспроизведения видео на вебстраницах с помощью расширений, скриптов или, как в последних версиях Firefox, встроенными средствами браузера.

### Дополнительное окно в плеере

При проигрывании видео в плеере, в левом верхнем углу отображается имя видеофайла, чаще всего соответствующее имени основной страницы, на котором выложен видеофайл. Нажатие на него выводит контекстное меню программы, откуда можно открыть страницу в другом плеере, браузере, скачать файл и пр.. Окно скрывается автоматически при переходе плеера в полный экран. Если окно не видно при максимизации плеера, возможно, он выводится поверх всех окон (нажатие Ctrl+A изменяет режим отображения плеера).
В настройках можно изменить размер шрифта окна или выключить его полностью.

### Скачивание видео

Для этого используется утилита командной строки youtube-dl, расположенная в одноменной папке. Папка youtube-dl содержит батники закачки и обновления, появляющиеся в контекстном меню программы (созданные или переименованные батники появляются в меню после перезапуска). Вызываем контекстное меню, выбираем требуемый пункт, появляется окно командной строки с отображением процесса скачивания (производится по умолчанию в папку Downloads в каталоге программы, но ее положение можно изменить в настройках). Качать можно несколько файлов одновременно - процессы не влияют друг на друга, если только нет совпадения имен.

Используемые в батниках переменные:
- %1 - адрес страницы

- %2 - папка закачки (из настроек программы)

Краткие пояснения по использованию смотри в них самих.

### MPC-BE - настройки и обновление ###

Настройки воспроизведения онлайн-видео находятся *Вид - Настройки - Воспроизведение - Онлайнсервисы:*

<img src="https://i.ibb.co/ssHFJck/2020-08-20-16-52-45-916x670.png" alt="2020-08-20-16-52-45-916x670" border="0" style="zoom: 50%;" >

Исходное положение галок соответствует воспроизведению всего возможного встроенными средствами плеера, а youtube-dl во всех прочих местах. Соответственно, если выключить встроенный движок плеера, все видео будет воспроизводиться средствами youtube-dl (может быть актуально, если на youtube в очередной раз что-то начудили и  видео перестало воспроизводиться). 

> Важно: в связи посточнными изменениями на youtube, ведущими к утрате работоспособности плеера, верхняя галка встроенного движка сейчас по умолчанию снята. Чаще обновляйте youtube-dl!

Обновить youtube-dl можно средствами программы, для обновления же MPC-BE придется скачать последнюю бета-версию [MPC-BE.XXX.x86.7z ](https://yadi.sk/d/AjAXDDHtHRIELg/Beta%20(Nightly)/1.5.5) (при этом следует сохранить файл mpc-be.ini).

Об использовании на планшете. MPC-BE  поддерживает управление с помощью тачскрина, что описано [здесь](http://forum.ru-board.com/topic.cgi?forum=5&topic=48073&start=3070&limit=1&m=1#1), но это работает только в полном экране. Поэтому имеет смысл зайти в *Настройки - Видео - Полный экран*, включить полный экран при запуске и выключить автоскрытие панели управления.

### Добавление сторонних утилит в меню программы

В каталоге программы имеется папка *open_in*, в которую можно добавлять свои утилиты для открытия страниц и ссылок, отображаемые в контекстном меню. Для этого достаточно просто скопировать туда ярлык (например, дополнительного плеера, альтернативного браузера для быстрого открытия в нем страницы) или добавить батник .
Поддерживаются файлы расширений bat, cmd, ps1, lnk, ahk, vbs. Вложенные папки игнорируются. Для применения изменений требуется перезапуск программы.

### Настройки и портативность

Настройки быстро открываются из контекстного меню иконки в трее или через редактирование файла *tube2.ini* (нужен перезапуск программы для применения изменений). 
"Из коробки" программа портативна в обоих версиях. При желании, можно разнести плеер, браузер, QuiteRSS и папку загрузки по разным папкам ==одного== диска, при этом сохранив ее портативность. Для этого следует добавить знак минус перед абсолютными путями в настройках - в этом случае буква диска будет меняться при запуске с флэшки на ту же, с которй запущена программа.

### Использование RSS-версии программы

QuiteRSS позволяет прописывать в настройках внешний браузер, и вместо него можно было бы прописать плеер, но тогда теряется возможность читать обычные ленты новостей. Здесь в качестве браузера прописывается tube2, и она решает, открывать ли новость в плеере или браузере в соответствии с настройками.

Простейший способ запустить QuiteRSS - щелкнуть два раза по иконке программы в трее или использовать сочетание Ctrl+Win+Q, по которому окно программы появляется или закрывается (при этом в настройках самой программы можно оставить ее запущенной в трее). Можно изменить настройки (параметр *start=1*) так, что QuiteRSS будет запускаться при старте программы и закрываться с закрытием окна QuiteRSS (иконка программы в трее в этом случае не отображается).

> Важно: программа не будет открывать ролики в плеере при самостоятельном запуске - нужен запуск из tube2!

Само использование почти ничем не отличается от браузерного, только все идет применительно к окну QuiteRSS и отображаемым в нем новостным лентам. 

#### Горячие клавиши в QuiteRSS

- Двойной, средний клик по новости или Enter - открытие новости (если ссылка идет на страницу сайта с видео, прописанного в настройках - открытие в плеере, иначе - в браузере)
- Shift+Enter, Shift+клик средней кнопкой мыши - принудительное открытие новости в браузере вне зависимости от адреса (для чтения коментариев к видео и пр.)
- Ctrl+Enter, Ctrl+средний клик, Ctrl+Shift+Enter, Ctrl+Shift+средний клик - все это отображает меню программы для скачивания видео и др.

### Подписки youtube, другие сайты и видеохостинги ###

Адреса rss-лент youtube раньше совпадали с url основной страницы канала, сейчас это уже не работает. Поэтому надо экспортировать их в opml в [менеджере подписок](https://www.youtube.com/subscription_manager) и импортировать в QuiteRSS зацело или доставая оттуда нужные адреса в блокноте. Для добавления штучных подписок можно использовать расширения [YouTube RSS Finder](https://addons.mozilla.org/en-US/firefox/addon/youtube-rss-finder/?src=search) для Firefox или [Youtube RSS](https://chrome.google.com/webstore/detail/youtube-rss/cmkhdimgaondkfghelifknnpicdajeim) для Chrome.

Youtube-dl позволяет просматривать видео с сотен сайтов, многие из которых имеют ленты новостей. Этот вопрос не изучался, но чтобы лента открывалась в плеере вместо браузера, достаточно прописать их в QuiteRSSPlus.ini через запятую:

```
sites=youtube.com,site.com,site2.com...
```

Префиксы протокола и начальные `www.` опустить, пробелы не допускаются!

### QuiteRSS - настройки и обновление

В сборке использована портативная версия QuiteRSS. Ее настройки состоят из двух файлов:

-   QuiteRss.ini - собственно настройки
-   feeds.db - база данных с лентами и их содержимым

Сами настройки QuiteRSS не принципиальны, и можно их сбросить, удалив QuiteRss.ini или поменяв программу на ту, которой пользовались раньше, но после следует изменить или проверить следующее: 

-   В *Настройки - Браузер - Внешний браузер* он долежен быть включен и в поле *Следующий внешний браузер* прописано `tube2.exe` без пути. 
-   В *Настройки - Браузер* снимите галку в на стройках "Открывать ссылки во внешнем браузере в фоновом режиме". 
-   Открытие новости во внешнем браузере должно стоять по горячей клавише Ctrl+O, как по умолчанию.

### Приложение 1. Просмотр и скачивание с запароленных сайтов

Для скачивания с сайтов, требующих авторизации, можно дописать в батники подстроку `-u логин -p пароль`. Это требует батников для каждого сайта и не позволяет смотреть видео. Здесь для авторизации youtube-dl используются два конфигурационных файла, которые благодаря изменению переменных окружения помещаются прямо в папке youtube-dl.
Файл config.txt, имеющий строку `--netrc` , подключает файл .netrc, в котором и хранятся пароли в виде отдельных строк. Для vk.com такая строка будет иметь вид:

```
machine vk login email password пароль
```

Здесь опущены точка и доменная зона - осталось только доменное имя. В config.txt можно висывать общие настройки батников - смотри документацию  youtube-dl.

### Приложение 2. Другие плееры и пр.

- Программа добавляет папку youtube-dl к переменной *PATH*, поэтому почти любой плеер, работающий с youtube-dl  (MPC-HC, MPV и др.), можно сразу подключать как основной или дополнительный плеер. 
- MPC-HC имеет настройки качества видео находящиеся в разделе *Дополнительно - YDL-параметры*. Можно ограничить высоту видео и задать командную строку youtube-dl.
- PotPlayer имеет встроенное расширение для youtube, находящееся в папке Extension (с youtube-dl не работает) . При неработоспособности - обновлять расширения через соответствующий раздел настроек (там можно включить автообновление) или менять файлы расширения из новой версии, открыв установочный файл в архиваторе. 
- MPV и MPV.NET, как было сказано, имеют встроенную поддержку youtube-dl. По умолчанию выбирается лучшее качество "в одном файле", для установки произвольного можно использовать параметры командной строки в настройках (параметр *player*). Синтаксис аналогичен youtube-dl, например, ограничение высоты в 480 пикселей будет иметь вид `--ytdl-format="bestvideo[height<=480]+bestaudio/best[height<=480]"`
- Если у вас хорошая акустика и в роликах интересует прежде всего звук, можно попробовать foobar2000 с плагинами [Youtube component for foobar2000](https://fy.3dyd.com/) и ASIO.
- MPC-BE открывает acestream-ссылки при установке пакета AceStream. Для просмотра magnet- и acestream- ссылок можно установить [Soda Player](https://www.sodaplayer.com/) и закинуть его ярлык в папку open_in.
- Простейшими средствами для получения url видео в онлайн-кинотеатрах являются расширения [Video DownloadHelper](https://addons.mozilla.org/en-US/firefox/addon/video-downloadhelper/) для Firefox или [Free Video Downloader](https://chrome.google.com/webstore/detail/free-video-dоwnlоader/lmieilamoollaknppoffbmdgdcolcafa?hl=en) для Chrome.



