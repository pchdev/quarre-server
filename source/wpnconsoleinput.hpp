#ifndef WPNCONSOLEINPUT_HPP
#define WPNCONSOLEINPUT_HPP

#include <QObject>
#include <QSocketNotifier>
#include <iostream>
#include <QQmlContext>

class WPNConsoleInput : public QObject
{
    Q_OBJECT

    public:
    WPNConsoleInput();
    WPNConsoleInput(QQmlContext* ctx, QObject* component);

    signals:
    void messageIn(QString msg);

    public slots:
    void run();

    protected slots:
    void parseCommand();

    private:
    QObject* m_component;
    QQmlContext* m_ctx;
    QSocketNotifier* m_notifier;
};

#endif // WPNCONSOLEINPUT_HPP
