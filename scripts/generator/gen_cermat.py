# -*- coding: utf-8 -*-
"""
Generátor Apex importů pro CERMAT testy (jednotná přijímací zkouška).
Stejné schéma úlohy jako gen.py, navíc CERMAT pole:
  Source_Type__c = 'CERMAT', CERMAT_Code__c = <kód testu>, Source_Year__c = <rok>.

Data soubor nastaví PŘED voláním chunk_files:
    import gen_cermat as g
    g.CCODE = 'M5PAD26C0T01'
    g.YEAR  = 2026
Schéma dictu úlohy je IDENTICKÉ jako v gen.py (name/zad/opts/ln/svg/fn/alt/cap/sol/ans/pts/mins/diff/codes).
"""

SRC   = 'CERMAT – jednotná přijímací zkouška'
STYPE = 'CERMAT'
CCODE = ''      # nastaví data soubor (kód testu, např. M5PAD26C0T01)
YEAR  = None    # nastaví data soubor (rok, např. 2026)

def lit(s):
    if s is None:
        return 'null'
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

HEADER = r'''String SRC   = %SRC%;
String STYPE = %STYPE%;
String CCODE = %CCODE%;
Integer YEAR = %YEAR%;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
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
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

'''

FOOTER = "\nSystem.debug('Vytvořeno úloh: '+c.created);\n"

def header():
    if not CCODE or YEAR is None:
        raise SystemExit('Nastav gen_cermat.CCODE a gen_cermat.YEAR před generováním!')
    return (HEADER.replace('%SRC%', lit(SRC)).replace('%STYPE%', lit(STYPE))
                  .replace('%CCODE%', lit(CCODE)).replace('%YEAR%', str(int(YEAR))))

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

def py_content_json(p):
    blocks = [{"type": "paragraph", "text": t} for t in p['zad']]
    if p.get('svg'):
        blocks.append({"type": "image", "contentDocumentId": "X", "alt": p.get('alt'),
                       "caption": p.get('cap'), "widthPercent": 75, "align": "center"})
    if p.get('opts'):
        blocks.append({"type": "list", "items": p['opts']})
    if p.get('ln'):
        blocks.append({"type": "answerSpace", "lines": p['ln']})
    return {"schemaVersion": 1, "blocks": blocks}

def py_solution_json(p):
    return {"schemaVersion": 1, "blocks": [{"type": "paragraph", "text": t} for t in p['sol']]}

def py_answer_json(p):
    return {"type": "Text", "value": p['ans']}

def chunk_files(problems, out_prefix, max_bytes=8600):
    h = header()
    base = len(h.encode('utf-8')) + len(FOOTER.encode('utf-8'))
    files = []
    cur, cur_sz = [], base
    for p in problems:
        blk = emit_add(p); bsz = len(blk.encode('utf-8'))
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
