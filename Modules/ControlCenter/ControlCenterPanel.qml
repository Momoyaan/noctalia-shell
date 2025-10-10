import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.Modules.ControlCenter.Cards
import qs.Commons
import qs.Services
import qs.Widgets

NPanel {
  id: root

  preferredWidth: 400
  preferredHeight: topHeight + midHeight + bottomHeight + audioHeight + Math.round(Style.marginL * 5)
  panelKeyboardFocus: true

  readonly property int topHeight: {
    const columns = (Settings.data.controlCenter.quickSettingsStyle === "compact") ? 4 : 3
    const rowsCount = Math.ceil(Settings.data.controlCenter.widgets.quickSettings.length / columns)

    var buttonHeight
    if (Settings.data.controlCenter.quickSettingsStyle === "classic") {
      buttonHeight = Style.baseWidgetSize
    } else if (Settings.data.controlCenter.quickSettingsStyle === "compact") {
      buttonHeight = Style.baseWidgetSize * 0.8 // Smaller for compact
    } else {
      buttonHeight = 56
    }

    return (rowsCount * buttonHeight) + 120
  }
  readonly property int midHeight: 220
  readonly property int bottomHeight: 80
  readonly property int audioHeight: 120

  // Positioning
  readonly property string controlCenterPosition: Settings.data.controlCenter.position
  panelAnchorHorizontalCenter: controlCenterPosition !== "close_to_bar_button" && controlCenterPosition.endsWith("_center")
  panelAnchorVerticalCenter: false
  panelAnchorLeft: controlCenterPosition !== "close_to_bar_button" && controlCenterPosition.endsWith("_left")
  panelAnchorRight: controlCenterPosition !== "close_to_bar_button" && controlCenterPosition.endsWith("_right")
  panelAnchorBottom: controlCenterPosition !== "close_to_bar_button" && controlCenterPosition.startsWith("bottom_")
  panelAnchorTop: controlCenterPosition !== "close_to_bar_button" && controlCenterPosition.startsWith("top_")

  panelContent: Item {
    id: content

    property real cardSpacing: Style.marginL * scaling

    // Layout content
    ColumnLayout {
      id: layout
      anchors.fill: parent
      anchors.margins: content.cardSpacing
      spacing: content.cardSpacing

      // Top Card: profile + utilities
      TopCard {
        id: topCard
        Layout.fillWidth: true
        Layout.preferredHeight: topHeight * scaling
      }

      // Audio controls card
      AudioCard {
        Layout.fillWidth: true
        Layout.preferredHeight: audioHeight * scaling
      }

      // Media card
      MediaCard {
        Layout.fillWidth: true
        Layout.preferredHeight: midHeight * scaling
      }

      // System monitors combined in one card
      SystemMonitorCard {
        Layout.fillWidth: true
        Layout.preferredHeight: bottomHeight * scaling
      }
    }
  }
}
