### Dynamic churn prediction for customer retention 

### Background Information

In the current days when market competition is a challenge for all industries. Customer retention is an important factor to consider for organizations to become profitable. The profit will be generated when the organization can successfully retain its customers and generate profit after recovering the initial investment spent for acquiring the customer. After successfully identifying the customers who are more likely to churn, we can implement proactive measures to retain them by understanding the factors responsible for churn. This will help the organization to improve the marketing in the long term. The dynamic nature of the model will allow adding new data with the passage of time which will improve the churn prediction and make the model more efficient and improve its accuracy.

### Statement of the Problem

The objective of this project is to predict the customers who are more likely to churn in a scenario where the customer data is constantly being updated with new information. The implemented solution should allow an organization to view customers who are likely to churn and view the accuracy of the churn model with new incoming data.

### Proposed Solution

The proposed solution is to build and deploy an application that will make use of different machine learning algorithms to predict the churn of customers and display the accuracy of the current model. This solution can be utilized by the telecom industry in two ways: a) When an end customer has called the customer support team, it will inform the customer support executive to try to resolve the customer complaints on call and ensure the customer is fully satisfied with the resolution. 
b) This information can be passed on to marketing or business development teams to offer discounts to predicted customers to retain them.

### Work Scope 

The work scope is to understand the different existing churn prediction algorithms and select the best algorithm to improve its accuracy which can be implemented in a scenario where customer data is dynamic which will result in a dynamic churn prediction model. The work will also include implementing a source mechanism that will constantly look for a change in the source database and if a scant change is detected, it would re-build the model to consider newly added data which will lead to more relevant and better accuracy of the churn prediction model each time.

## Work Flow 

![image](https://user-images.githubusercontent.com/11299574/124966415-ecc82300-e040-11eb-9a87-c6f9ed8b0f59.png)

### References 

* Bhanuprakash, P., & Nagaraja, G. S. (2018). A Review on Churn Prediction Modeling in Telecom Environment. 2nd International Conference on Computational Systems and Information Technology for Sustainable Solutions, CSITSS 2017, 8–12. https://doi.org/10.1109/CSITSS.2017.8447617 
* Tamaddoni, A., Sepehri, M. M., & Caruana, A. (2009). Predicting Customer Churn in Telecommunications Service Providers. Department of Business Administration and Social Sciences, Masters(2009:052), 88. https://pure.ltu.se/ws/files/31140128/LTU-PB-EX-09052-SE.pdf 
* Xiao, J., Wang, Y., & Wang, S. (2014). A dynamic transfer ensemble model for customer churn prediction. Proceedings - 2013 6th International Conference on Business Intelligence and Financial Engineering, BIFE 2013, 115–119. https://doi.org/10.1109/BIFE.2013.26 
* Xiong, A., You, Y., & Long, L. (2019). L-RBF: A customer churn prediction model based on lasso + RBF. Proceedings - 2019 IEEE International Congress on Cybermatics: 12th IEEE International Conference on Internet of Things, 15th IEEE International Conference on Green Computing and Communications, 12th IEEE International Conference on Cyber, Physical and Social Computing and 5th IEEE International Conference on Smart Data, IThings/GreenCom/CPSCom/SmartData 2019, 621–626. https://doi.org/10.1109/iThings/GreenCom/CPSCom/SmartData.2019.00121 
* Hu, X., Yang, Y., Chen, L., & Zhu, S. (2020). Research on a Customer Churn Combination Prediction Model Based on Decision Tree and Neural Network. 2020 IEEE 5th International Conference on Cloud Computing and Big Data Analytics, ICCCBDA 2020, 129–132. https://doi.org/10.1109/ICCCBDA49378.2020.9095611 

## Future Scope

Observe data drift and analyze machine learning models during validation and production monitoring.

1. Data Drift - Detect changes in feature distribution.
2. Numerical Target Drift - Detect changes in numerical target and feature behavior.
3. Categorical Target Drift - Detect changes in categorical target and feature behavior.
4. Regression Model Performance - Analyze the performance of a regression model and model errors.
5. Classification Model Performance - Analyze the performance and errors of a classification model. Works both for binary and multi-class models.
6. Probabilistic Classification Model Performance - Analyze the performance of a probabilistic classification model, quality of model calibration, and model errors. Works both for binary and multi-class models.
