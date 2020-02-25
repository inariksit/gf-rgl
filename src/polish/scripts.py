#!/usr/bin/env python

from subprocess import Popen, PIPE, check_output
from forms import forms
from collections import defaultdict

# s = check_output(["echo", "Hello World!"]).decode("utf-8")
# print("s = {}".format(s))

def format(filename):
    strs = open(filename)
    print("forms = {")
    for str in strs:
        if str.startswith("<--"):
            pass #print("{")
        if str.startswith("    oper "):
            nm = str[9:21]
            print('"{}": {{'.format(nm))
        if str.startswith("-->"):
            print("},")
        if str.startswith("      "):
            casenum = str[6:12]
            form = str[20:][:-1]
            comma = '' if casenum=="Pl_Voc" else ','
            print('"{}": {}{}'.format(casenum, form, comma))
    print("}")
#format("nouns-a.txt")

def format_hs(filename):
    strs = open(filename)
    print("""module Paradigms where
import qualified Data.Text as T

data Case = Sg_Nom | Sg_Gen | Sg_Dat | Sg_Acc | Sg_Ins | Sg_Loc | Sg_Voc
              | Pl_Nom | Pl_Gen | Pl_Dat | Pl_Acc | Pl_Ins | Pl_Loc | Pl_Voc
      deriving (Show, Eq, Ord, Enum)
""")
    print("paradigms = [")
    for str in strs:
        if str.startswith('"'):
            print('    ({} ['.format(str[:-1]))
        if str.startswith("S") or str.startswith("P"):
            case = str[:6]
            form = str[6:][:-1]
            comma = ']' if case=="Pl_Voc" else ','
            print("        ({}, T.pack{}){}".format(case,form,comma))
        if str.startswith("--"):
            print("    ),")
    print("    ]")

#format_hs("nouns-a-hs.txt")

def format_tabeleusz(filename):
    strs = open(filename)
    d = {}
    for s in strs:
        ss = s.split()
        lemma = ss[1].lower()
        form = ss[0].lower()
        tags = ss[2].split('|')
        for tag in tags:
            print("{} {} {}".format(lemma, form, tag))
            

format_tabeleusz("odm-morfeusz.txt")



## -------------------------------------------------------------------------- ##

def allomorphs_per_case(paradigms, cas):
    d = defaultdict(int)
    for dict in paradigms.values():
        form = dict[cas]
        d[form] += 1
    return d


cases = ['Sg_Nom', 'Sg_Gen', 'Sg_Dat', 'Sg_Acc', 'Sg_Ins', 'Sg_Loc', 'Sg_Voc', 'Pl_Nom', 'Pl_Gen', 'Pl_Dat', 'Pl_Acc', 'Pl_Ins', 'Pl_Loc', 'Pl_Voc']

#
# for case in cases:
#     wfs = allomorphs_per_case(forms, case)
#     wfs = sorted(wfs.items(), key=lambda k_v: k_v[1], reverse=True)
#     print("\n{}".format(case))
#     for s in wfs:
#         print("{}: {}".format(s[1], s[0]))

def foo(paradigms, cases_forms):
    """Takes a dict of {paradigm: {case: form}}, list of ("Case", "form")
    and returns the dicts that have given forms for given cases
    """
    dict = {}
    for paradigm, inftable in paradigms.items():
        for case, form in cases_forms:
            if inftable[case] == form:
                dict[paradigm] = inftable
    return dict

cases_forms = [("Sg_Gen", "y")]

sggen_y = foo(forms, cases_forms)


# for case in cases:
#     wfs = allomorphs_per_case(sggen_y, case)
#     wfs = sorted(wfs.items(), key=lambda k_v: k_v[1], reverse=True)
#     print("\n{}".format(case))
#     for s in wfs:
#         print("{}: {}".format(s[1], s[0]))
