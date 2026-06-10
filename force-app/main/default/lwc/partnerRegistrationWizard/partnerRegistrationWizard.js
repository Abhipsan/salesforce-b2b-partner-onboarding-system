import { LightningElement } from 'lwc';

import createPartnerApplication
from '@salesforce/apex/PartnerRegistrationController.createPartnerApplication';

import { ShowToastEvent }
from 'lightning/platformShowToastEvent';

export default class PartnerRegistrationWizard
    extends LightningElement {

    companyName = '';
    businessEmail = '';
    region = '';

    regionOptions = [

        { label: 'Asia', value: 'Asia' },

        { label: 'Europe', value: 'Europe' },

        {
            label: 'North America',
            value: 'North America'
        }
    ];

    handleCompanyName(event) {

        this.companyName = event.target.value;
    }

    handleBusinessEmail(event) {

        this.businessEmail = event.target.value;
    }

    handleRegionChange(event) {

        this.region = event.target.value;
    }

    handleSubmit() {

        // Validation
        if(
            !this.companyName ||
            !this.businessEmail ||
            !this.region
        ) {

            this.showToast(
                'Validation Error',
                'Please fill all fields',
                'error'
            );

            return;
        }

        // Apex Call
        createPartnerApplication({

            companyName: this.companyName,

            businessEmail: this.businessEmail,

            region: this.region
        })

        .then(result => {

            // Success Toast
            this.showToast(
                'Success',
                result,
                'success'
            );

            // Reset Form
            this.companyName = '';

            this.businessEmail = '';

            this.region = '';

            console.log(result);
        })

        .catch(error => {

            console.error(error);

            this.showToast(
                'Error',
                'Failed to create application',
                'error'
            );
        });
    }

    // Toast Method
    showToast(title, message, variant) {

        const event = new ShowToastEvent({

            title: title,

            message: message,

            variant: variant
        });

        this.dispatchEvent(event);
    }
}