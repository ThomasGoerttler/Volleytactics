#pragma once

#include "core/QmlPluginRegistry.h"

class Config : public QObject
{
	Q_OBJECT

	MTQ_QML_PLUGIN_REGISTRATION(Config, "system")

public:
	Q_INVOKABLE bool contains(const QString key) const;
	Q_INVOKABLE bool contains(const QString group, const QString key) const;
	Q_INVOKABLE QVariant value(const QString key) const;
	Q_INVOKABLE QVariant value(const QString group, const QString key) const;
};
