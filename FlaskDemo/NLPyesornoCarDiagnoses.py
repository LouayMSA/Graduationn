# %%
from tkinter import YES
import numpy as np
import pandas as pd
from pathlib import Path
import pandas as pd
import sklearn
from sklearn.preprocessing import LabelEncoder
from sklearn import tree
p = pd.read_csv("MixedSet2.csv")

data = p

# %%
X =  data.iloc[:, :-1].values
""" print(X) """
y = data.iloc[:, -1].values
""" print(y) """


# %%
dimensionality_reduction = data.groupby(data['problem']).max()
""" yes """


# %%
from sklearn.preprocessing import LabelEncoder
labelencoder = LabelEncoder()
y = labelencoder.fit_transform(y)
""" print(y) """

# %%
model = tree.DecisionTreeClassifier()
model.fit(X,y)

# %%
model


# %%
cols     = data.columns
cols     = cols[:-1]

# %%
importances = model.feature_importances_
indices = np.argsort(importances)[::-1]
features = cols

# %%
from sklearn.tree import _tree

# %%
def execute_bot():

    print("Please reply with yes/Yes or no/No for the following symptoms") 
    def print_problem(node):
        #print(node)
        node = node[0]
        #print(len(node))
        val  = node.nonzero() 
        #print(val)
        problem = labelencoder.inverse_transform(val[0])
        return problem
    def tree_to_code(tree, feature_names):
        tree_ = tree.tree_
        #print(tree_)
        feature_name = [
            feature_names[i] if i != _tree.TREE_UNDEFINED else "undefined!"
            for i in tree_.feature
        ]
        symptoms_present = []
        def recurse(node, depth):
            indent = "  " * depth
            if tree_.feature[node] != _tree.TREE_UNDEFINED:
                name = feature_name[node]
                threshold = tree_.threshold[node]
                print(name + " ?")
                ans = input()
                ans = ans.lower()
                if ans == 'yes':
                    val = 1
                else:
                    val = 0
                if  val <= threshold:
                    recurse(tree_.children_left[node], depth + 1)
                else:
                    symptoms_present.append(name)
                    recurse(tree_.children_right[node], depth + 1)
            else:
                present_problem = print_problem(tree_.value[node])
                
                print('The Model Suggests:')
                print()
                print( "You may have: " +  present_problem )
                print()
                row = CarDiagnose[CarDiagnose['problem'] == present_problem[0]]
                print('Description: ', str(row['Description'].values))
                print()
                print('Inspection List: ', str(row['InspectionList'].values))
    
        recurse(0, 1)
    
    tree_to_code(model,cols)




# %%
""" D = pd.read_csv('CarDiagnose.csv') """

Isnpection_dataset = pd.read_csv("CarDiagnose.csv", names = ['Description','InspectionList'])

problem = dimensionality_reduction.index
problem = pd.DataFrame(problem)

CarDiagnose = pd.DataFrame()

CarDiagnose['Description'] = np.nan
CarDiagnose['InspectionList'] = np.nan

CarDiagnose['problem'] = np.nan
CarDiagnose['problem'] = problem['problem']


CarDiagnose['Description'] = Isnpection_dataset['Description']
CarDiagnose['InspectionList'] = Isnpection_dataset['InspectionList']


# %%
execute_bot()

# %%
import pickle

filename = 'savedmodel.sav'
pickle.dump(model,open(filename,'wb'))

# %%
load_model = pickle.load(open(filename,'rb'))

# %%
""" load_model() """


