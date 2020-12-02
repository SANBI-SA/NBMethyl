
#script for LibSVM machine prediction
# install libSVM and import files in svm format 

#==========================================================================
from libsvm.svmutil import *
from sklearn.metrics import confusion_matrix
from sklearn.metrics import classification_report

#import training file
y, x = svm_read_problem("./Training-MYCN.svm")
cross_val_accuracy = svm_train(y, x, '-c 10 -t 1 -v 5')

# Copyright (C) 2020  Hocine Bendou <hocine@sanbi.ac.za>
#                     Abdulazeez Giwa <3901476@myuwc.ac.za>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>

#===========================================================================

#import GSE54721 testing dataset
y2, x2 = svm_read_problem("./Testing-54721.svm")

#model
model = svm_train(y, x, '-c 10 -t 0')

#predict
p_label, p_acc, p_val = svm_predict(y2, x2, model)

#reports
confusion_matrix(y2, p_label)
print(classification_report(y2, p_label))


#===========================================================================

#import GSE65306 testing dataset
y3, x3 = svm_read_problem("./Testing-65306.svm")

#model
model1 = svm_train(y, x, '-c 10 -t 0')

#predict
p_label1, p_acc1, p_val1 = svm_predict(y3, x3, model1)

#reports
confusion_matrix(y3, p_label1)
print(classification_report(y3, p_label1))

#===========================================================================

#import GSE120650 testing dataset
y4, x4 = svm_read_problem("/home/agiwa/Documents/RC-Updated/DD/ML/files/Testing-120650.svm")

#model
model2 = svm_train(y, x, '-c 30 -t 1')

#predict
p_label2, p_acc2, p_val2 = svm_predict(y4, x4, model2)

#reports
confusion_matrix(y4, p_label2)
print(classification_report(y4, p_label2))

#===========================================================================











