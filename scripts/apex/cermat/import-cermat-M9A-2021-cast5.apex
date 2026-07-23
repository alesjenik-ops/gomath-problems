String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD21C0T01';
Integer YEAR = 2021;

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

c.add(
  'CERMAT M9A 2021 – úloha 14',
  new List<String>{'Všechny rodiny z Jižní a Severní ulice uvedly, kolik chovají psů. Výsledky šetření jsou uvedeny v tabulce (některá pole nejsou vyplněna).','Právě $3$ psy chová v Severní ulici dvakrát více rodin než v Jižní ulici. Kolik rodin bydlí v Severní ulici?'},
  new List<String>{'A) $40$','B) $42$','C) $44$','D) $46$','E) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 155" font-family="sans-serif"> <line x1="10" y1="20" x2="470" y2="20" stroke="#000"/> <line x1="10" y1="80" x2="470" y2="80" stroke="#000"/> <line x1="10" y1="110" x2="470" y2="110" stroke="#000"/> <line x1="10" y1="140" x2="470" y2="140" stroke="#000"/> <line x1="150" y1="48" x2="370" y2="48" stroke="#000"/> <line x1="10" y1="20" x2="10" y2="140" stroke="#000"/> <line x1="70" y1="20" x2="70" y2="140" stroke="#000"/> <line x1="150" y1="20" x2="150" y2="140" stroke="#000"/> <line x1="370" y1="20" x2="370" y2="140" stroke="#000"/> <line x1="470" y1="20" x2="470" y2="140" stroke="#000"/> <line x1="205" y1="48" x2="205" y2="140" stroke="#000"/> <line x1="260" y1="48" x2="260" y2="140" stroke="#000"/> <line x1="315" y1="48" x2="315" y2="140" stroke="#000"/> <text x="40" y="54" font-size="12" text-anchor="middle">Ulice</text> <text x="110" y="42" font-size="11" text-anchor="middle">Počet všech</text> <text x="110" y="60" font-size="11" text-anchor="middle">rodin</text> <text x="260" y="40" font-size="11" text-anchor="middle">Počet rodin, které chovají</text> <text x="177" y="68" font-size="11" text-anchor="middle">0 psů</text> <text x="232" y="68" font-size="11" text-anchor="middle">1 psa</text> <text x="287" y="68" font-size="11" text-anchor="middle">2 psy</text> <text x="342" y="68" font-size="11" text-anchor="middle">3 psy</text> <text x="420" y="42" font-size="11" text-anchor="middle">Aritmetický průměr</text> <text x="420" y="58" font-size="11" text-anchor="middle">počtu chovaných</text> <text x="420" y="74" font-size="11" text-anchor="middle">psů</text> <text x="16" y="99" font-size="12">Jižní</text> <text x="110" y="99" font-size="12" text-anchor="middle">48</text> <text x="177" y="99" font-size="12" text-anchor="middle">33</text> <text x="287" y="99" font-size="12" text-anchor="middle">5</text> <text x="420" y="99" font-size="12" text-anchor="middle">0,5</text> <text x="16" y="129" font-size="12">Severní</text> <text x="177" y="129" font-size="12" text-anchor="middle">23</text> <text x="232" y="129" font-size="12" text-anchor="middle">12</text> <text x="287" y="129" font-size="12" text-anchor="middle">1</text> <line x1="376" y1="113" x2="464" y2="137" stroke="#000"/> <line x1="376" y1="137" x2="464" y2="113" stroke="#000"/> </svg>',
  'tabulka-psi.svg',
  'Tabulka počtu chovaných psů. Jižní ulice: 48 rodin, 0 psů 33, 2 psy 5, průměr 0,5. Severní ulice: 0 psů 23, 1 psa 12, 2 psy 1.',
  'Počty rodin podle počtu chovaných psů',
  new List<String>{'Jižní ulice: celkem $48$ rodin. Neznámé počty $1$ psa ($j_1$) a $3$ psy ($j_3$). Součet rodin: $33+j_1+5+j_3=48$, tj. $j_1+j_3=10$. Průměr $0{,}5$: $\\dfrac{j_1+2\\cdot 5+3j_3}{48}=0{,}5$, tj. $j_1+3j_3=14$. Odečtením $2j_3=4$, $j_3=2$.','V Severní ulici chová $3$ psy dvakrát více rodin: $2\\cdot 2=4$. Počet rodin v Severní ulici $=23+12+1+4=40$.'},
  'A) $40$',
  2, 5, '3',
  new List<String>{'zs2','r9','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
