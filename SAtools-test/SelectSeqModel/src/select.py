# Script: select.py
# Description: train model / use trained-model to predict
# Update date: 2019/08/04(unfinished)
# Author: Zhuofan Zhang

import argparse
from sklearn.preprocessing import StandardScaler,Normalizer
from sklearn import svm
from joblib import dump,load
import numpy as np

def train(InputFile,OutputModel):
    raw_data = np.genfromtxt(InputFile,delimiter=',')
    tr_data = raw_data[:,:-1]
    tr_label = raw_data[:,-1]
    # standardization and normalization
    tr_data = StandardScaler().fit_transform(tr_data)
    tr_data = Normalizer().fit_transform(tr_data)

    # Model training
    SVM = svm.SVC()
    SVM.fit(tr_data,tr_label)
    # Save the model
    dump(SVM, "{}.m".format(OutputModel))



def predict(InputFile,OutputFile,Model):
    pass


if __name__ == '__main__':
    Parser = argparse.ArgumentParser()
    Parser.add_argument('-i',help="input blast8-format file.")
    Parser.add_argument('-o',help="[train-mode] model file;[eval-mode] predict result.")
    Parser.add_argument('--mode',help="train/eval mode select;default=train",default="train")
    Parser.add_argument('--model',help="under eval mode,load the trained-model.",default=None)
    args = Parser.parse_args()

    if args.mode == "train":
        train(args.i,args.o)
    elif args.mode == "eval":
        if args.model != None:
            predict(args.i,args.o,args.model)
        else:
            except ValueError:
                print("No model has been selected!")
    else:
        except ValueError:
            print("--mode: 'train' or 'eval'.")       