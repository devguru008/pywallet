import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

Pane {
    objectName: 'About'

    property string title: qsTr("About Pywallet")

    Flickable {
        anchors.fill: parent
        contentHeight: rootLayout.height
        interactive: height < contentHeight

        GridLayout {
            id: rootLayout
            columns: 2
            width: parent.width

            Item {
                Layout.columnSpan: 2
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: parent.width * 3/4 // reduce height, empty space in png

                Image {
                    id: pywallet_logo
                    width: parent.width
                    height: width
                    source: '../../icons/pywallet_presplash.png'
                }
            }

            Label {
                text: qsTr('Version')
                Layout.alignment: Qt.AlignRight
            }
            Label {
                text: BUILD.pywallet_version
            }
            Label {
                text: qsTr('Protocol version')
                Layout.alignment: Qt.AlignRight
            }
            Label {
                text: BUILD.protocol_version
            }
            Label {
                text: qsTr('Qt Version')
                Layout.alignment: Qt.AlignRight
            }
            Label {
                text: BUILD.qt_version
            }
            Label {
                text: qsTr('PyQt Version')
                Layout.alignment: Qt.AlignRight
            }
            Label {
                text: BUILD.pyqt_version
            }
            Label {
                text: qsTr('License')
                Layout.alignment: Qt.AlignRight
            }
            Label {
                text: qsTr('MIT License')
            }
            Label {
                text: qsTr('Homepage')
                Layout.alignment: Qt.AlignRight
            }
            Label {
                text: qsTr('<a href="https://wallet.caprifin.co">https://wallet.caprifin.co</a>')
                textFormat: Text.RichText
                onLinkActivated: Qt.openUrlExternally(link)
            }
            Label {
                text: qsTr('Developers')
                Layout.alignment: Qt.AlignRight
            }
            Label {
                text: 'Thomas Voegtlin\nSomberNight\nSander van Grieken'
            }
            Item {
                width: 1
                height: constants.paddingXLarge
                Layout.columnSpan: 2
            }
            Label {
                text: qsTr('Distributed by Pywallet Technologies GmbH')
                Layout.columnSpan: 2
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

}
