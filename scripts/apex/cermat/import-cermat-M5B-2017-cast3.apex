String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD17C0T02';
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
  'CERMAT M5B 2017 – úloha 8',
  new List<String>{'Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 Vzdálenost $32$ cm je 4krát větší než vzdálenost $128$ mm.','8.2 Vzdálenost $128$ mm je 4krát větší než vzdálenost $32$ cm.','8.3 Čtverec se stranou délky $6$ cm je možné rozdělit na $9$ čtverců se stranou délky $20$ mm.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'8.1 $128$ mm $= 12{,}8$ cm; $4\\cdot 12{,}8 = 51{,}2$ cm, což není $32$ cm. Nepravda (Ne).','8.2 $128$ mm $= 12{,}8$ cm je menší než $32$ cm, nemůže tedy být 4krát větší. Nepravda (Ne).','8.3 $20$ mm $= 2$ cm; čtverec $6\\times 6$ cm lze rozdělit na mřížku $3\\times 3$ čtverců se stranou $2$ cm, tj. na $9$ čtverců. Pravda (Ano).'},
  '8.1: Ne; 8.2: Ne; 8.3: Ano',
  4, 5, '2',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2017 – úloha 9',
  new List<String>{'Ve kterém z pěti obrázků je dvojice útvarů souměrná podle vyznačené osy souměrnosti $o$? (Obrázky 1–5 viz zadání.)'},
  new List<String>{'A) jen v obrázku 1','B) jen v obrázku 2','C) ve dvou z pěti obrázků','D) ve třech z pěti obrázků','E) ve čtyřech z pěti obrázků'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif"><line x1="20" y1="105" x2="540" y2="105" stroke="#000" stroke-width="1.5"/><text x="545" y="110" font-size="13" font-style="italic">o</text><rect x="30" y="20" width="90" height="170" fill="none" stroke="#bbb"/><text x="75" y="16" font-size="13" text-anchor="middle">1</text><polygon points="52,38 88,38 88,54 68,54 68,86 52,86" fill="#cccccc" stroke="#666"/><polygon points="52,172 88,172 88,156 68,156 68,124 52,124" fill="#cccccc" stroke="#666"/><rect x="134" y="20" width="90" height="170" fill="none" stroke="#bbb"/><text x="179" y="16" font-size="13" text-anchor="middle">2</text><polygon points="156,38 192,38 192,54 172,54 172,86 156,86" fill="#cccccc" stroke="#666"/><polygon points="156,172 192,172 192,156 172,156 172,124 156,124" fill="#cccccc" stroke="#666"/><rect x="238" y="20" width="90" height="170" fill="none" stroke="#bbb"/><text x="283" y="16" font-size="13" text-anchor="middle">3</text><polygon points="260,38 296,38 296,54 276,54 276,86 260,86" fill="#cccccc" stroke="#666"/><polygon points="260,172 296,172 296,156 276,156 276,124 260,124" fill="#cccccc" stroke="#666"/><rect x="342" y="20" width="90" height="170" fill="none" stroke="#bbb"/><text x="387" y="16" font-size="13" text-anchor="middle">4</text><polygon points="364,38 400,38 400,54 380,54 380,86 364,86" fill="#cccccc" stroke="#666"/><polygon points="364,172 400,172 400,156 380,156 380,124 364,124" fill="#cccccc" stroke="#666"/><rect x="446" y="20" width="90" height="170" fill="none" stroke="#bbb"/><text x="491" y="16" font-size="13" text-anchor="middle">5</text><polygon points="468,38 504,38 504,54 484,54 484,86 468,86" fill="#cccccc" stroke="#666"/><polygon points="468,172 504,172 504,156 484,156 484,124 468,124" fill="#cccccc" stroke="#666"/></svg>',
  'osy.svg',
  'Pět čtvercových sítí (1 až 5), v každé dvojice útvarů a vodorovná osa souměrnosti o.',
  'Obrázky 1 až 5 k úloze 9 (schematicky)',
  new List<String>{'Osová souměrnost podle vodorovné osy $o$ nastává, když je horní útvar zrcadlovým obrazem dolního. Této podmínce vyhovuje pouze obrázek 1.'},
  'A) jen v obrázku 1',
  2, 3, '3',
  new List<String>{'zs1','planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
