String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD23C0T03';
Integer YEAR = 2023;

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
  'CERMAT M5C 2023 – úloha 1.1',
  new List<String>{'Vypočtěte: $(2 \\cdot 910 + 600) : 11 - 1 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Podle pořadí operací: $2\\cdot 910+600=2\\,420$, $2\\,420:11=220$, $220-1=219$.'},
  '$219$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2023 – úloha 1.2',
  new List<String>{'Vypočtěte: $73 \\cdot 15 - 23 \\cdot 15 + 50 \\cdot 35 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(73-23)\\cdot 15+50\\cdot 35=50\\cdot 15+1\\,750=750+1\\,750=2\\,500$.'},
  '$2\\,500$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2023 – úloha 2.1',
  new List<String>{'Představení trvalo i s přestávkou 2 hodiny 35 minut. Přestávka tvořila jednu pětinu této doby.','Vypočtěte, kolik minut trvala přestávka.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$2$ hodiny $35$ minut $=155$ minut. Přestávka $=\\frac{1}{5}\\cdot 155=31$ minut.'},
  '$31$ minut',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2023 – úloha 2.2',
  new List<String>{'Lomená čára se skládá ze dvou úseček. Délka celé lomené čáry je 2 m 4 cm 2 mm a první úsečka je dlouhá 52 cm 6 mm.','Vypočtěte v mm délku druhé úsečky lomené čáry.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Celá čára $=2\\,042$ mm, první úsečka $=526$ mm. Druhá úsečka $=2\\,042-526=1\\,516$ mm.'},
  '$1\\,516$ mm',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2023 – úloha 3.1',
  new List<String>{'Adam, Běta i Cyril sbírají kartičky s pokémony. Adam jich má o 50 více než Běta a Cyril jich má o 20 méně než Běta. Adam jich má dvakrát více než Cyril.','Vypočtěte, kolik kartiček s pokémony má Běta.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet kartiček Běty $b$. Adam má $b+50$, Cyril $b-20$. Z $b+50=2(b-20)$ plyne $b+50=2b-40$, tedy $b=90$. (Adam $140$, Cyril $70$.)'},
  '$90$ kartiček',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2023 – úloha 3.2',
  new List<String>{'V obchodě prodávají sběratelské kartičky v baleních jednak po čtyřech, jednak po sedmi kartičkách. Během týdne prodali celkem 224 kartiček, přičemž balení po čtyřech kartičkách prodali o 10 méně než balení po sedmi kartičkách.','Vypočtěte, kolik balení sběratelských kartiček během týdne celkem prodali.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet balení po sedmi $s$; balení po čtyřech je $s-10$. Pak $7s+4(s-10)=224$, tj. $11s-40=224$, $s=24$. Balení po čtyřech je $14$. Celkem $24+14=38$ balení.'},
  '$38$ balení',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2023 – úloha 4.1',
  new List<String>{'Závodník uběhl celou trasu za 3 hodiny. Během první hodiny uběhl třetinu celé trasy. Během poslední hodiny uběhl jen 9 km, což byla čtvrtina celé trasy.','Vypočtěte, kolik km uběhl závodník během druhé hodiny.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Poslední hodina: $9$ km $=\\frac{1}{4}$ trasy, celá trasa $=36$ km. První hodina $=\\frac{1}{3}\\cdot 36=12$ km. Druhá hodina $=36-12-9=15$ km.'},
  '$15$ km',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2023 – úloha 4.2',
  new List<String>{'Při rozklusání uběhla Ema o 900 m kratší trasu než Marek. Oba běželi nejprve spolu. Jakmile Marek uběhl pětinu své trasy, zrychlil a dále běželi každý sám. Ema v doprovodu Marka uběhla třetinu své trasy.','Vypočtěte, kolik metrů uběhl při rozklusání Marek.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Společná část je pětina Markovy trasy a zároveň třetina Eminy trasy. Označme Markovu trasu $m$; Emina je $m-900$. Pak $\\frac{1}{5}m=\\frac{1}{3}(m-900)$, tj. $3m=5(m-900)$, $2m=4\\,500$, $m=2\\,250$ m.'},
  '$2\\,250$ m',
  2, 5, '4',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
