/****************************************************************************
** Meta object code from reading C++ file 'networkmanage.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.14.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../PostgraduateApp/networkmanage.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'networkmanage.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.14.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_Networkmanage_t {
    QByteArrayData data[10];
    char stringdata0[107];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Networkmanage_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Networkmanage_t qt_meta_stringdata_Networkmanage = {
    {
QT_MOC_LITERAL(0, 0, 13), // "Networkmanage"
QT_MOC_LITERAL(1, 14, 14), // "connect_server"
QT_MOC_LITERAL(2, 29, 0), // ""
QT_MOC_LITERAL(3, 30, 17), // "register_userinfo"
QT_MOC_LITERAL(4, 48, 8), // "username"
QT_MOC_LITERAL(5, 57, 3), // "pwd"
QT_MOC_LITERAL(6, 61, 5), // "login"
QT_MOC_LITERAL(7, 67, 15), // "receive_article"
QT_MOC_LITERAL(8, 83, 10), // "sendsingal"
QT_MOC_LITERAL(9, 94, 12) // "receive_size"

    },
    "Networkmanage\0connect_server\0\0"
    "register_userinfo\0username\0pwd\0login\0"
    "receive_article\0sendsingal\0receive_size"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Networkmanage[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    0,   44,    2, 0x02 /* Public */,
       3,    2,   45,    2, 0x02 /* Public */,
       6,    2,   50,    2, 0x02 /* Public */,
       7,    0,   55,    2, 0x02 /* Public */,
       8,    0,   56,    2, 0x02 /* Public */,
       9,    0,   57,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString,    4,    5,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString,    4,    5,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Int,

       0        // eod
};

void Networkmanage::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Networkmanage *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->connect_server(); break;
        case 1: { bool _r = _t->register_userinfo((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 2: { bool _r = _t->login((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: { QString _r = _t->receive_article();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->sendsingal();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 5: { int _r = _t->receive_size();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject Networkmanage::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_Networkmanage.data,
    qt_meta_data_Networkmanage,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *Networkmanage::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Networkmanage::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_Networkmanage.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Networkmanage::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 6;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
