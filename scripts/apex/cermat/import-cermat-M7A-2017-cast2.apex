String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD17C0T01';
Integer YEAR = 2017;

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
  'CERMAT M7A 2017 – úloha 5',
  new List<String>{'Na první číselné ose jsou vyznačeny tři stejně velké díly, na druhé ose čtyři. $A$, $B$, $C$, $D$ představují čtyři neznámá čísla. Šipka na první ose znamená vynásobení dvěma, šipka na druhé ose přičtení čísla 36.','5.1 Určete neznámá čísla $A$ a $B$.','5.2 Určete neznámá čísla $C$ a $D$.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 200" font-family="sans-serif"> <line x1="40" y1="80" x2="330" y2="80" stroke="#000" stroke-width="2.5"/> <line x1="90" y1="66" x2="90" y2="94" stroke="#000" stroke-width="2.5"/> <line x1="150" y1="66" x2="150" y2="94" stroke="#000" stroke-width="2.5"/> <line x1="210" y1="66" x2="210" y2="94" stroke="#000" stroke-width="2.5"/> <line x1="270" y1="66" x2="270" y2="94" stroke="#000" stroke-width="2.5"/> <text x="90" y="52" font-size="17" text-anchor="middle">A</text> <text x="150" y="52" font-size="17" text-anchor="middle">B</text> <text x="270" y="52" font-size="17" text-anchor="middle">36</text> <path d="M90,96 Q180,168 266,102" fill="none" stroke="#000" stroke-width="2.5"/> <polygon points="270,94 258,104 268,110" fill="#000"/> <circle cx="180" cy="146" r="20" fill="#fff" stroke="#000" stroke-width="2.5"/> <text x="180" y="153" font-size="16" text-anchor="middle" font-weight="bold">. 2</text> <line x1="380" y1="80" x2="700" y2="80" stroke="#000" stroke-width="2.5"/> <line x1="410" y1="66" x2="410" y2="94" stroke="#000" stroke-width="2.5"/> <line x1="465" y1="66" x2="465" y2="94" stroke="#000" stroke-width="2.5"/> <line x1="520" y1="66" x2="520" y2="94" stroke="#000" stroke-width="2.5"/> <line x1="575" y1="66" x2="575" y2="94" stroke="#000" stroke-width="2.5"/> <line x1="630" y1="66" x2="630" y2="94" stroke="#000" stroke-width="2.5"/> <text x="465" y="52" font-size="17" text-anchor="middle">C</text> <text x="575" y="52" font-size="17" text-anchor="middle">50</text> <text x="630" y="52" font-size="17" text-anchor="middle">D</text> <path d="M410,96 Q520,176 626,102" fill="none" stroke="#000" stroke-width="2.5"/> <polygon points="630,94 618,104 628,110" fill="#000"/> <circle cx="520" cy="152" r="22" fill="#fff" stroke="#000" stroke-width="2.5"/> <text x="520" y="159" font-size="16" text-anchor="middle" font-weight="bold">+36</text> </svg>',
  'ciselne-osy.svg',
  'Dvě číselné osy: na první díly s body A, B a 36 a šipka krát 2, na druhé díly s body C, 50 a D a šipka plus 36.',
  'Výchozí obrázek k úloze 5',
  new List<String>{'5.1 Šipka vede z bodu $A$ do čísla 36, tedy $2A=36$, $A=18$. Tři stejné díly mezi 18 a 36 mají velikost $(36-18):3=6$, proto $B=18+6=24$.','5.2 Šipka vede z prvního dílku do bodu $D$, tedy $D$ je o 36 větší; čtyři díly odpovídají 36, jeden díl je $36:4=9$. Z čísla 50 (čtvrtý dílek) plyne $D=50+9=59$ a $C=50-2\\cdot 9=32$.'},
  '5.1: $A=18$; $B=24$; 5.2: $C=32$; $D=59$',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2017 – úloha 6',
  new List<String>{'Tři různé tyče měří 24 cm, 60 cm a 84 cm. Úkolem je rozřezat beze zbytku všechny tři tyče na co nejmenší počet stejně dlouhých dílů. Po rozřezání tyčí se všechny plochy vzniklé po řezu obarví.','6.1 Vypočtěte v cm délku jednoho dílu.','6.2 Určete, kolik dílů bude třeba obarvit z obou stran.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Nejmenší počet dílů dostaneme při největší možné délce dílu, tj. $D(24;60;84)=12$ cm.','6.2 Počty dílů: $24:12=2$, $60:12=5$, $84:12=7$. Z obou stran se barví jen vnitřní díly, tedy $0+3+5=8$ dílů.'},
  '6.1: $12$ cm; 6.2: $8$ dílů',
  2, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2017 – úloha 7',
  new List<String>{'Běžec udržuje stálé tempo. Každých $0{,}2$ km uběhne za 45 s. Uveďte postup řešení.','7.1 Určete v minutách a sekundách, za jak dlouho uběhne 1 km.','7.2 Určete počet metrů, které uběhne za 9 minut.'},
  null,
  6,
  null,
  null,
  null,
  null,
  new List<String>{'7.1 $1$ km $=5\\cdot 0{,}2$ km, tedy $5\\cdot 45$ s $=225$ s $=3$ min $45$ s.','7.2 $9$ min $=540$ s $=12\\cdot 45$ s, tedy $12\\cdot 0{,}2$ km $=2{,}4$ km $=2\\,400$ m.'},
  '7.1: $3$ min $45$ s; 7.2: $2\\,400$ m',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
