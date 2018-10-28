#include "wpnconsoleinput.hpp"
#include <QQmlExpression>
#include <QtDebug>

WPNConsoleInput::WPNConsoleInput(QQmlContext* ctx, QObject* component) :
    m_notifier(new QSocketNotifier(fileno(stdin), QSocketNotifier::Read, this)),
    m_ctx(ctx),
    m_component(component)
{
    if ( !m_component ) qDebug() << "no component";
}

WPNConsoleInput::WPNConsoleInput() :
    m_notifier(new QSocketNotifier(fileno(stdin), QSocketNotifier::Read, this)),
    m_ctx(nullptr), m_component(nullptr)
{

}

void WPNConsoleInput::run()
{
    std::cout << "> " << std::flush;
    connect(m_notifier, SIGNAL(activated(int)), this, SLOT(parseCommand()));
}

void WPNConsoleInput::parseCommand()
{
    std::string line;
    std::getline(std::cin, line);

    QQmlExpression expr(m_ctx, m_component, QString::fromStdString(line));
    expr.setSourceLocation("main.qml", 170, 0);
    expr.evaluate();
    qDebug() << expr.error();

    std::cout << "> " << std::flush;
}
