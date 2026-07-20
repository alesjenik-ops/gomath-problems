#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Generator of anonymous Apex import scripts for GoMath, per importulohapexnavod.md.
Feed it a list of problem dicts; it emits Apex files chunked safely under ~9 KB.

Each problem dict:
  name : str (unique)                       -> Math_Problem__c.Name (idempotence)
  zad  : list[str]                          -> zadání paragraphs (natural LaTeX, raw)
  opts : list[str] | None                   -> multiple-choice options, else None
  ln   : int                                -> answer lines (0 = none)
  svg  : str | None                         -> SVG text (no ' or \\), else None
  fn   : str | None                         -> image filename e.g. 'obr.svg'
  alt  : str | None                         -> image alt (required if svg)
  cap  : str | None                         -> image caption ('' allowed)
  sol  : list[str]                          -> solution paragraphs
  ans  : str                                -> correct answer text (LaTeX in $...$)
  pts  : number                             -> Points__c
  mins : number                             -> Expected_Time_Min__c
  diff : str '1'..'5'                        -> Difficulty__c
  codes: list[str]                          -> taxonomy codes
"""
import json

SRC = 'Matematika - Zelený'
STYPE = 'Jiné'

# ---- Apex string helpers (double backslashes, escape apostrophes) ----
def lit(s):
    if s is None:
        return 'null'
    # Apex string literals cannot contain raw newlines; collapse them (safe for
    # SVG and for our text fields, which never rely on embedded newlines).
    s = str(s).replace('\r', ' ').replace('\n', ' ')
    return "'" + s.replace('\\', '\\\\').replace("'", "\\'") + "'"

def lst(items):
    if items is None:
        return 'null'
    return "new List<String>{" + ",".join(lit(x) for x in items) + "}"

def num(x):
    if x is None:
        return 'null'
    return str(x)

# ---- Fixed skeleton from the guide (class C MUST NOT be modified) ----
HEADER = r'''String SRC   = %SRC%;
String STYPE = %STYPE%;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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

'''

FOOTER = "\nSystem.debug('Vytvořeno úloh: '+c.created);\n"

def header():
    return HEADER.replace('%SRC%', lit(SRC)).replace('%STYPE%', lit(STYPE))

def py_content_json(p):
    """Mirror of the Apex content() builder — for offline JSON validation."""
    blocks = [{"type": "paragraph", "text": t} for t in p['zad']]
    if p.get('svg'):
        blocks.append({"type": "image", "contentDocumentId": "PLACEHOLDER",
                       "alt": p.get('alt'), "caption": p.get('cap'),
                       "widthPercent": 75, "align": "center"})
    if p.get('opts'):
        blocks.append({"type": "list", "items": p['opts']})
    if p.get('ln'):
        blocks.append({"type": "answerSpace", "lines": p['ln']})
    return {"schemaVersion": 1, "blocks": blocks}

def py_solution_json(p):
    return {"schemaVersion": 1, "blocks": [{"type": "paragraph", "text": t} for t in p['sol']]}

def py_answer_json(p):
    return {"type": "Text", "value": p['ans']}

def emit_add(p):
    return (
        "c.add(\n"
        f"  {lit(p['name'])},\n"
        f"  {lst(p['zad'])},\n"
        f"  {lst(p.get('opts'))},\n"
        f"  {num(p.get('ln', 0))},\n"
        f"  {lit(p.get('svg'))},\n"
        f"  {lit(p.get('fn'))},\n"
        f"  {lit(p.get('alt'))},\n"
        f"  {lit(p.get('cap'))},\n"
        f"  {lst(p['sol'])},\n"
        f"  {lit(p['ans'])},\n"
        f"  {num(p['pts'])}, {num(p['mins'])}, {lit(p['diff'])},\n"
        f"  {lst(p['codes'])}\n"
        ");\n"
    )

def chunk_files(problems, out_prefix, max_bytes=8600):
    """Split problems into as-large-as-possible files under max_bytes (< ~9KB)."""
    h = header()
    base = len(h.encode('utf-8')) + len(FOOTER.encode('utf-8'))
    files = []
    cur, cur_sz = [], base
    for p in problems:
        blk = emit_add(p)
        bsz = len(blk.encode('utf-8'))
        if cur and cur_sz + bsz > max_bytes:
            files.append(cur); cur, cur_sz = [], base
        cur.append((p, blk)); cur_sz += bsz
    if cur:
        files.append(cur)
    written = []
    n = len(files)
    for i, group in enumerate(files, 1):
        body = h + "".join(blk for _, blk in group) + FOOTER
        suffix = f"-cast{i}" if n > 1 else ""
        path = f"{out_prefix}{suffix}.apex"
        with open(path, 'w', encoding='utf-8') as f:
            f.write(body)
        written.append((path, len(body.encode('utf-8')), len(group)))
    return written

if __name__ == '__main__':
    # smoke test with one dummy problem
    demo = [{
        'name': 'DEMO – test 2+3', 'zad': ['Vypočtěte $2+3$.'], 'opts': None, 'ln': 1,
        'sol': ['Sečteme: $2+3=5$.'], 'ans': '$5$', 'pts': 1, 'mins': 2, 'diff': '1',
        'codes': ['zs2', 'r9', 'aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    }]
    import os
    outdir = os.path.dirname(os.path.abspath(__file__))
    w = chunk_files(demo, os.path.join(outdir, '_demo'))
    for path, sz, k in w:
        print(f"{path}: {sz} B, {k} úloh")
    # validate JSON-ability of the answer map is implicit; print header size
    print('header bytes:', len(header().encode('utf-8')))
