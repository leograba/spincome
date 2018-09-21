#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QTranslator>

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QTranslator translator;

    // look up e.g. :/translations/spincome_pt_BR.qm
    // For debug, a specific place can be set - QLocale(QLocale::Portuguese, QLocale::Brazil)
    if (translator.load(QLocale(), QLatin1String("spincome"), QLatin1String("_"), QLatin1String(":/translations")))
        app.installTranslator(&translator);
    else qDebug() << "main.cpp: Translation file not found. Region is: " << QLocale();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/src/qml/main.qml")));
    if (engine.rootObjects().isEmpty()){
        return -1;
    }
    else{
        qDebug() << "main.cpp: Application loaded!";
    }

    return app.exec();
}
