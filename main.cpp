#include <QApplication>
#include <QQuickWidget>
#include <QQmlComponent>
#include <QQuickItem>

#include <source/wpnconsoleinput.hpp>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);   

    qmlRegisterType<WPNConsoleInput, 1> ( "WPN214", 1, 0, "ConsoleInput");

    QQuickWidget view;
    view.setSource(QUrl::fromLocalFile("/Users/pchd/Repositories/quarre-server/resources/qml/main.qml"));
    view.show();

    return app.exec();
}
