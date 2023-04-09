import { LightningElement } from 'lwc';

export default class Challenge3 extends LightningElement {
    currClass = 'none';

    get boxClass() {
        return 'box ' + this.currClass;
    }

    redBox() {
        this.currClass = 'red';
    }

    blueBox() {
        this.currClass = 'blue';
    }

    greenBox() {
        this.currClass = 'green';
    }
}