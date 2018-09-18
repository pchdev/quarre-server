#ifndef FILEDIRECTORY_HPP
#define FILEDIRECTORY_HPP

#include <QObject>

class FileDirectory : public QObject
{
    Q_OBJECT

    Q_PROPERTY  ( QStringList fileList READ fileList NOTIFY onFileListChanged )
    Q_PROPERTY  ( QString path READ path WRITE setPath )
    Q_PROPERTY  ( bool recursive READ recursive WRITE setRecursive )

    public:
    FileDirectory();

    QStringList fileList() const { return m_filelist; }
    QString path() const { return m_path; }
    bool recursive() const { return m_recursive; }

    void setPath(QString path);
    void setRecursive(bool rec) { m_recursive = rec; }

    signals:
    void onFileListChanged();

    private:
    QStringList m_filelist;
    QString m_path;
    bool m_recursive;


};

#endif // FILEDIRECTORY_HPP
