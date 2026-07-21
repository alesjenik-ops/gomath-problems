String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 1. náhradní termín (M9C)';
String STYPE = 'CERMAT';

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

c.add(
  'CERMAT 2025 M9C · úloha 11',
  new List<String>{'Rodný dům je otevřen od května do září. V grafu je návštěvnost (děti a dospělí) v jedné sezoně.','Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):','11.1 V prvních třech měsících sezony bylo mezi návštěvníky třikrát více dospělých než dětí.','11.2 Za celou sezonu bylo dospělých návštěvníků průměrně $80$ za měsíc.','11.3 Za celou sezonu tvořily děti $40\\ \\%$ všech návštěvníků.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 405 192"><path d="M4 4L401 4L401 188L4 188ZM63 163L63 16M60 163L63 163M60 150L63 150M60 137L63 137M60 123L63 123M60 110L63 110M60 97L63 97M60 83L63 83M60 70L63 70M60 56L63 56M60 43L63 43M60 30L63 30M60 16L63 16M63 163L327 163M63 163L63 167M116 163L116 167M169 163L169 167M222 163L222 167M274 163L274 167M327 163L327 167" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M63 150L327 150M63 137L327 137M63 123L327 123M63 110L327 110M63 97L327 97M63 83L327 83M63 70L327 70M63 56L327 56M63 43L327 43M63 30L327 30M63 16L327 16" style="fill:none;stroke:#7f7f7f;stroke-width:1"/><path d="M73 123L90 123L90 163L73 163ZM126 150L142 150L142 163L126 163ZM179 123L195 123L195 163L179 163ZM232 97L248 97L248 163L232 163ZM284 110L301 110L301 163L284 163Z" style="fill:#595959;stroke:#000000;stroke-width:1"/><path d="M142 83L159 83L159 163L142 163Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:1"/><path d="M90 56L106 56L106 163L90 163ZM195 70L211 70L211 163L195 163ZM248 43L264 43L264 163L248 163ZM301 30L317 30L317 163L301 163Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:1"/><text x="49" y="169" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">0</text><text x="46" y="156" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">10</text><text x="46" y="142" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">20</text><text x="46" y="129" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">30</text><text x="46" y="115" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">40</text><text x="46" y="102" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">50</text><text x="46" y="89" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">60</text><text x="46" y="75" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">70</text><text x="46" y="62" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">80</text><text x="46" y="49" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">90</text><text x="43" y="35" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">100</text><text x="43" y="22" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">110</text><text x="90" y="181" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Květen</text><text x="143" y="181" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Červen</text><text x="195" y="181" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Červenec</text><text x="248" y="181" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Srpen</text><text x="301" y="181" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Září</text><text x="25" y="159" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Počet prodaných vstupenek</text></svg>',
  'obr.svg',
  'Sloupcový graf počtu prodaných vstupenek dětem a dospělým v měsících květen až září.',
  '',
  new List<String>{'Z grafu děti: $30,10,30,50,40$; dospělí: $80,60,70,90,100$.','11.1: prvních tři měsíce děti $70$, dospělí $210=3\\cdot70$ — A.','11.2: dospělých celkem $400$, průměr $\\frac{400}{5}=80$ — A.','11.3: dětí $160$ z celkových $560$, tj. asi $28{,}6\\ \\%$, nikoli $40\\ \\%$ — N.'},
  '11.1: A; 11.2: A; 11.3: N',
  4, 5, '3',
  new List<String>{'zs2','r9','statistika','procenta','porozumeni','bez-kalkulacky','bezny-zivot'},
  'M9PCD25C0T03', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
