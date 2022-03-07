from PyQt5.QtWidgets import QApplication, QWidget, QPushButton, QLabel, QLineEdit
import pyperclip

class window(QWidget):
    def __init__(self):
        QApplication.__init__(self)
        self.pxSizeX, self.pxSizeY = (6, 8)
        self.winSizeX, self.winSizeY = (self.pxSizeX * 20 + 20, self.pxSizeY * 20 + 90)
        self.px = [0] * self.pxSizeX * self.pxSizeY

        self.initUI()

    def initUI(self):
        self.setGeometry(100, 100, self.winSizeX, self.winSizeY)
        self.pxButtons = []
        for y in range(self.pxSizeY):
            for x in range(self.pxSizeX):
                self.pxButtons.append(QPushButton(self))
                self.pxButtons[-1].setGeometry(20 * x + 10, 20 * y + 10, 20, 20)
                self.pxButtons[-1].setStyleSheet('background-color: white')
                self.pxButtons[-1].clicked.connect(self.setPx)

        self.nameLabel = QLabel(self)
        self.nameLabel.setText('Name:')
        self.nameLabel.move(10, self.pxSizeY * 20 + 20)
        self.nameEntry = QLineEdit(self)
        self.nameEntry.setGeometry(70, self.pxSizeY * 20 + 20, 40, 20)

        self.addrLabel = QLabel(self)
        self.addrLabel.setText('Addr:')
        self.addrLabel.move(10, self.pxSizeY * 20 + 40)
        self.addrEntry = QLineEdit(self)
        self.addrEntry.setGeometry(70, self.pxSizeY * 20 + 40, 40, 20)

        self.exportButton = QPushButton(self)
        self.exportButton.setText('Export')
        self.exportButton.adjustSize()
        self.exportButton.move((self.winSizeX - int(self.exportButton.size().width())) / 2, self.winSizeY - int(self.exportButton.size().height()))
        self.exportButton.clicked.connect(self.export)

        self.show()

    def setPx(self):
        index = self.pxButtons.index(self.sender())
        self.px[index] = 1 - self.px[index]
        if self.px[index]:
            self.sender().setStyleSheet('background-color: grey')
        else:
            self.sender().setStyleSheet('background-color: white')

    def export(self):
        name = self.nameEntry.text()
        addr = self.addrEntry.text()
        exportStr = 'ASCII_{}:'.format(name).ljust(12) + '; 0x{}'.format(addr.upper())

        for y in range(self.pxSizeY):
            exportStr += '\n    .db %'
            for x in range(self.pxSizeX):
                i = y * self.pxSizeX + x
                exportStr += str(self.px[i])
            exportStr += '0' * (8 - self.pxSizeX)

        print('Export result:')
        print(exportStr)
        pyperclip.copy(exportStr)
        print('Result copied to clipboard.')

if __name__ == '__main__':
    app = QApplication([])
    win = window()
    exit(app.exec_())