#include "filedirectory.hpp"
#include <QDir>

FileDirectory::FileDirectory()
{

}

void FileDirectory::setPath(QString path)
{
    m_path = path;

    QDir dir(path);
    dir.setNameFilters(QStringList{"*.qml"});

    m_filelist = dir.entryList();
    emit onFileListChanged();
}

