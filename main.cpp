#include <QApplication>
#include <QQuickWidget>

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QApplication app(argc, argv);

    QQuickWidget* view = new QQuickWidget;
    view->setSource(QUrl::fromLocalFile("/Users/pchd/Repositories/quarre-server/resources/qml/main.qml"));
    view->show();
    return app.exec();
}
