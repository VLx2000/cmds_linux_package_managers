#!/bin/bash

#qdbus $KONSOLE_DBUS_SERVICE /konsole/MainWindow_1 org.kde.konsole.Konsole.MainWindow.viewFullScreen 1
qdbus $KONSOLE_DBUS_SERVICE /konsole/MainWindow_1 org.qtproject.Qt.QWidget.showMaximized
qdbus $KONSOLE_DBUS_SERVICE /konsole/MainWindow_1 org.kde.KMainWindow.activateAction split-view-left-right
qdbus $KONSOLE_DBUS_SERVICE /konsole/MainWindow_1 org.kde.KMainWindow.activateAction split-view-top-bottom
qdbus $KONSOLE_DBUS_SERVICE /Sessions/1 org.kde.konsole.Session.runCommand "bashtop"
qdbus $KONSOLE_DBUS_SERVICE /Sessions/2 org.kde.konsole.Session.runCommand "nvtop"
qdbus $KONSOLE_DBUS_SERVICE /Sessions/3 org.kde.konsole.Session.runCommand "neofetch"