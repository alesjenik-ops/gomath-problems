String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD25C0T01';
Integer YEAR = 2025;

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
  'CERMAT M9A 2025 - uloha 12',
  new List<String>{'Bazen ma delku $40$ metrU a sirku $10$ metrU. Hloubka bazenu neni vsude stejna (viz obrazek). V cele zone pro neplavce je hloubka $1$ m. Zona pro plavce ma sikme dno a hloubka bazenu se v ni postupne zvetsi z $1$ m na $2$ m.','Jaky je objem bazenu?'},
  new List<String>{'A) $500$ m3','B) $550$ m3','C) $600$ m3','D) $650$ m3','E) jiny objem'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 220" font-family="sans-serif"> <polygon points="50,60 420,60 420,150 240,110 50,110" fill="#dfeaf3" stroke="#000" stroke-width="1.5"/> <line x1="240" y1="60" x2="240" y2="110" stroke="#888" stroke-width="1" stroke-dasharray="4 4"/> <text x="145" y="45" font-size="12" text-anchor="middle">Zona pro neplavce</text> <text x="330" y="45" font-size="12" text-anchor="middle">Zona pro plavce</text> <text x="40" y="90" font-size="12" text-anchor="end">1 m</text> <text x="430" y="140" font-size="12">2 m</text> <text x="145" y="135" font-size="12" text-anchor="middle">20 m</text> <text x="235" y="185" font-size="12" text-anchor="middle">40 m</text> <line x1="50" y1="170" x2="420" y2="170" stroke="#000"/><line x1="50" y1="122" x2="240" y2="122" stroke="#000"/> <text x="360" y="205" font-size="12" text-anchor="middle">sirka bazenu 10 m</text> </svg>',
  'bazen.svg',
  'Podelny rez bazenem: zona pro neplavce s hloubkou 1 m a zona pro plavce se sikmym dnem od 1 m do 2 m.',
  'Schematicky rez bazenem',
  new List<String>{'Podelny rez: zona pro neplavce (delka $20$ m, hloubka $1$ m) ma obsah $20$ m2; zona pro plavce (lichobeznik s hloubkami $1$ m a $2$ m na delce $20$ m) ma obsah $\\frac{1+2}{2}\\cdot 20=30$ m2. Celkem rez $50$ m2, objem $=50\\cdot 10=500$ m3.'},
  'A) $500$ m3',
  2, 5, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2025 - uloha 13',
  new List<String>{'U Pelhrimova se letos poradaly detske tabory ve dvou terminech. Pocet nabizenych mist byl v obou terminech stejny. Seslo se celkem $375$ prihlasek. V prvnim terminu pocet prihlasek prekrocil pocet nabizenych mist o petinu, ve druhem terminu o $30\\,\\%$.','Kolik prihlasek celkem muselo byt kvUli nedostatku mist odmitnuto?'},
  new List<String>{'A) $65$ prihlasek','B) $75$ prihlasek','C) $80$ prihlasek','D) $85$ prihlasek','E) jiny pocet prihlasek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Nabizenych mist v kazdem terminu je $m$. Prihlasek $1{,}2m+1{,}3m=2{,}5m=375$, tedy $m=150$. Odmitnuto $0{,}2m+0{,}3m=0{,}5m=0{,}5\\cdot 150=75$.'},
  'B) $75$ prihlasek',
  2, 4, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2025 - uloha 14',
  new List<String>{'Test z matematiky psalo $20$ zakU. Nejhorsi znamka byla $3$. Pocet jednicek a dvojek byl stejny. Aritmeticky prumer znamek vsech zakU byl $1{,}8$. Znamky $4$ a $5$ nedostal nikdo.','Kolik zakU dostalo z testu znamku $1$?'},
  new List<String>{'A) $5$ zakU','B) $6$ zakU','C) $7$ zakU','D) $8$ zakU','E) $9$ zakU'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 80" font-family="sans-serif"> <rect x="15" y="12" width="410" height="52" fill="none" stroke="#000"/> <line x1="15" y1="38" x2="425" y2="38" stroke="#000"/> <line x1="125" y1="12" x2="125" y2="64" stroke="#000"/> <line x1="185" y1="12" x2="185" y2="64" stroke="#000"/><line x1="245" y1="12" x2="245" y2="64" stroke="#000"/> <line x1="305" y1="12" x2="305" y2="64" stroke="#000"/><line x1="365" y1="12" x2="365" y2="64" stroke="#000"/> <text x="20" y="31" font-size="13">Znamka</text><text x="20" y="57" font-size="13">Pocet zaku</text> <text x="155" y="31" font-size="13" text-anchor="middle">1</text><text x="215" y="31" font-size="13" text-anchor="middle">2</text><text x="275" y="31" font-size="13" text-anchor="middle">3</text><text x="335" y="31" font-size="13" text-anchor="middle">4</text><text x="395" y="31" font-size="13" text-anchor="middle">5</text> <text x="155" y="57" font-size="13" text-anchor="middle" font-weight="bold">?</text><text x="335" y="57" font-size="13" text-anchor="middle">0</text><text x="395" y="57" font-size="13" text-anchor="middle">0</text> </svg>',
  'tabulka-znamky.svg',
  'Tabulka: znamky 1 az 5 a pocet zakU; u znamky 1 je otaznik, u znamek 4 a 5 je 0.',
  'Tabulka znamek',
  new List<String>{'NechT jednicek i dvojek je $a$ a trojek $t$. Pak $2a+t=20$ a prumer $\\frac{1\\cdot a+2\\cdot a+3\\cdot t}{20}=1{,}8$, tj. $3a+3t=36$, tedy $a+t=12$. Odectenim $a=8$.'},
  'D) $8$ zakU',
  2, 4, '3',
  new List<String>{'zs2','r9','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
