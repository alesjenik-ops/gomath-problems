"""Generate anonymous-Apex import scripts for GoMath from problem data.

Follows scripts/apex návod: kostra class C (one published version per
problem, Answer_JSON as {"type":"Text","value":...}), extended with the
CERMAT fields (Source_Type__c='CERMAT', CERMAT_Code__c, Source_Year__c).

Author problems with NATURAL LaTeX (raw strings); this module doubles the
backslashes and escapes apostrophes for the Apex literal, validates that
every $…$ is paired and that the emitted content/solution/answer JSON parse,
and splits the output into <9 KB parts.
"""
import json
import re


# ---------- Apex literal helpers ----------
def lit(s):
    return "'" + s.replace("\\", "\\\\").replace("'", "\\'") + "'"


def lst(items):
    if items is None:
        return "null"
    return "new List<String>{" + ",".join(lit(x) for x in items) + "}"


def _num(x):
    if x is None:
        return "null"
    if isinstance(x, int):
        return str(x)
    return repr(float(x))


# ---------- validation (mirror of the Apex JSON builders) ----------
def _check_math(s, where):
    if s.count("$") % 2 != 0:
        raise ValueError("nepárový $ v %s: %r" % (where, s))


def _para(t):
    return {"type": "paragraph", "text": t}


def _content_json(zad, has_img, opts, ln):
    blocks = [_para(t) for t in zad]
    if has_img:
        blocks.append({"type": "image", "contentDocumentId": "0" * 18,
                       "alt": "x", "caption": "", "widthPercent": 75, "align": "center"})
    if opts:
        blocks.append({"type": "list", "items": list(opts)})
    if ln:
        blocks.append({"type": "answerSpace", "lines": ln})
    return {"schemaVersion": 1, "blocks": blocks}


def _solution_json(solp):
    return {"schemaVersion": 1, "blocks": [_para(t) for t in solp]}


DIFF_OK = {"1", "2", "3", "4", "5"}


def validate(p):
    name = p["name"]
    for t in p["zad"]:
        _check_math(t, name + " zadání")
    for t in p.get("solp", []):
        _check_math(t, name + " řešení")
    for t in (p.get("opts") or []):
        _check_math(t, name + " opts")
    _check_math(p["ans"], name + " odpověď")
    if p["diff"] not in DIFF_OK:
        raise ValueError("diff mimo 1..5 v %s: %r" % (name, p["diff"]))
    # JSON must serialize/parse
    json.loads(json.dumps(_content_json(p["zad"], bool(p.get("svg")), p.get("opts"), p.get("ln"))))
    json.loads(json.dumps(_solution_json(p.get("solp", []))))
    json.loads(json.dumps({"type": "Text", "value": p["ans"]}))
    if p.get("svg"):
        if "'" in p["svg"] or "\\" in p["svg"]:
            raise ValueError("SVG obsahuje ' nebo \\ v %s" % name)
        if not p.get("alt"):
            raise ValueError("obrázek bez alt v %s" % name)


# ---------- Apex emission ----------
HEADER = """String SRC   = %(src)s;
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{\"type\":\"paragraph\",\"text\":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{\"schemaVersion\":1,\"blocks\":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{\"type\":\"image\",\"contentDocumentId\":\"'+d+'\",\"alt\":'+JSON.serialize(alt)+',\"caption\":'+JSON.serialize(cap)+',\"widthPercent\":75,\"align\":\"center\"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{\"type\":\"list\",\"items\":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{\"type\":\"answerSpace\",\"lines\":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{\"schemaVersion\":1,\"blocks\":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE);

"""

FOOTER = "\nSystem.debug('Vytvořeno úloh: '+c.created);\n"


def _add_call(p, ccode, yr):
    return (
        "c.add(\n  %s,\n  %s,\n  %s,\n  %s,\n  %s,\n  %s,\n  %s,\n  %s,\n  %s,\n  %s,\n  %s, %s, %s,\n  %s,\n  %s, %s\n);\n"
        % (
            lit(p["name"]),
            lst(p["zad"]),
            lst(p.get("opts")),
            _num(p.get("ln")),
            lit(p["svg"]) if p.get("svg") else "null",
            lit(p["fn"]) if p.get("svg") else "null",
            lit(p["alt"]) if p.get("svg") else "null",
            lit(p.get("cap", "")) if p.get("svg") else "null",
            lst(p.get("solp", [])),
            lit(p["ans"]),
            _num(p["pts"]), _num(p["mins"]), lit(p["diff"]),
            lst(p["codes"]),
            lit(ccode), _num(yr),
        )
    )


def emit(problems, src, ccode, yr, out_prefix, budget=8900):
    """Validate all problems, then write out_prefix-castN.apex files < budget."""
    import glob as _glob
    import os as _os
    for old in _glob.glob(out_prefix + "*.apex"):
        _os.remove(old)
    for p in problems:
        validate(p)
    def blen(s):
        return len(s.encode("utf-8"))

    header = HEADER % {"src": lit(src)}
    calls = [_add_call(p, ccode, yr) for p in problems]
    files = []
    cur, cur_names = [], []
    base = blen(header) + blen(FOOTER)
    size = base
    for p, call in zip(problems, calls):
        if cur and size + blen(call) > budget:
            files.append((list(cur), list(cur_names)))
            cur, cur_names, size = [], [], base
        cur.append(call)
        cur_names.append(p["name"])
        size += blen(call)
    if cur:
        files.append((cur, cur_names))
    written = []
    n = len(files)
    for i, (calls_i, names_i) in enumerate(files, 1):
        suffix = ("-cast%d" % i) if n > 1 else ""
        path = "%s%s.apex" % (out_prefix, suffix)
        body = header + "".join(calls_i) + FOOTER
        open(path, "w").write(body)
        written.append((path, blen(body), names_i))
    return written
