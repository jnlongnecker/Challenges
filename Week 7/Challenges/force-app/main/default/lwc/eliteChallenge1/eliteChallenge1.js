import { LightningElement } from 'lwc';

export default class EliteChallenge1 extends LightningElement {
    pixels = [...Array(25).keys()];

    currRed = 100;
    currBlue = 100;
    currGreen = 100;

    mouseDown = false;

    get colorStyle() {
        return `background-color: rgb(${this.currRed},${this.currGreen},${this.currBlue});`;
    }

    updateColor() {
        this.currRed = this.refs.red.value;
        this.currBlue = this.refs.blue.value;
        this.currGreen = this.refs.green.value;
    }

    setMouseDown() {
        this.mouseDown = true;
    }

    setMouseUp() {
        this.mouseDown = false;
    }

    paint(event) {
        let div = event.target;
        if (!this.mouseDown) return;

        div.setAttribute('style', this.colorStyle);
    }

    tileClick(event) {
        this.mouseDown = true;
        this.paint(event);
    }
}