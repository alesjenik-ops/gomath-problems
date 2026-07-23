String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD26C0T02';
Integer YEAR = 2026;

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
  'CERMAT M9B 2026 – úloha 12',
  new List<String>{'V trojúhelníkovém diagramu se do prázdných kroužků doplní taková kladná celá čísla, aby byl součin tří čísel na každé straně trojúhelníku stejný (viz obrázek).','Jaký je součet obou čísel doplněných do prázdných kroužků diagramu?'},
  new List<String>{'A) $11$','B) $14$','C) $19$','D) $22$','E) jiný součet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 320" font-family="sans-serif"><line x1="120" y1="70" x2="360" y2="70" stroke="#000" stroke-width="1.5"/><line x1="120" y1="70" x2="240" y2="275" stroke="#000" stroke-width="1.5"/><line x1="360" y1="70" x2="240" y2="275" stroke="#000" stroke-width="1.5"/><circle cx="120" cy="70" r="22" fill="#ffffff" stroke="#000" stroke-width="1.5"/><circle cx="360" cy="70" r="22" fill="#ffffff" stroke="#000" stroke-width="1.5"/><text x="360" y="76" font-size="18" text-anchor="middle">8</text><circle cx="240" cy="275" r="22" fill="#ffffff" stroke="#000" stroke-width="1.5"/><circle cx="240.0" cy="70.0" r="22" fill="#ffffff" stroke="#000" stroke-width="1.5"/><text x="240.0" y="76.0" font-size="18" text-anchor="middle">6</text><circle cx="180.0" cy="172.5" r="22" fill="#ffffff" stroke="#000" stroke-width="1.5"/><text x="180.0" y="178.5" font-size="18" text-anchor="middle">4</text><circle cx="300.0" cy="172.5" r="22" fill="#ffffff" stroke="#000" stroke-width="1.5"/><text x="300.0" y="178.5" font-size="18" text-anchor="middle">5</text></svg>',
  'diagram-trojuhelnik.svg',
  'Trojúhelníkový diagram se šesti kroužky; na stranách jsou čísla 6, 8, 4, 5 a dva kroužky (horní levý a dolní) jsou prázdné.',
  'Trojúhelníkový diagram (součin tří čísel na každé straně je stejný)',
  new List<String>{'Označme horní levý kroužek $t$ a dolní kroužek $d$. Strany dávají součiny $t\\cdot 6\\cdot 8$, $8\\cdot 5\\cdot d$ a $t\\cdot 4\\cdot d$. Z rovnosti $48t=4td$ plyne $d=12$, z rovnosti $48t=40d$ pak $t=10$. Součet doplněných čísel je $10+12=22$.'},
  'D) $22$',
  2, 5, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2026 – úloha 13',
  new List<String>{'Z krychle o hraně délky $10$ cm byly vyříznuty čtyři shodné malé krychličky o hraně délky $2$ cm. Vzniklo tak nové těleso (viz obrázek).','Jaký je povrch nového tělesa?'},
  new List<String>{'A) $552$ cm²','B) $584$ cm²','C) $600$ cm²','D) $616$ cm²','E) jiný povrch'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 210" font-family="sans-serif"> <text x="115" y="22" font-size="13" text-anchor="middle">Krychle</text> <text x="382" y="22" font-size="13" text-anchor="middle">Nove teleso</text> <polygon points="55,70 145,70 145,160 55,160" fill="#e8e8e8" stroke="#000" stroke-width="1.5"/> <polygon points="55,70 90,45 180,45 145,70" fill="#f4f4f4" stroke="#000" stroke-width="1.5"/> <polygon points="145,70 180,45 180,135 145,160" fill="#d5d5d5" stroke="#000" stroke-width="1.5"/> <polygon points="320,70 410,70 410,160 320,160" fill="#e8e8e8" stroke="#000" stroke-width="1.5"/> <polygon points="320,70 355,45 445,45 410,70" fill="#f4f4f4" stroke="#000" stroke-width="1.5"/> <polygon points="410,70 445,45 445,135 410,160" fill="#d5d5d5" stroke="#000" stroke-width="1.5"/> <rect x="320" y="70" width="16" height="16" fill="#ffffff" stroke="#000"/> <rect x="394" y="70" width="16" height="16" fill="#ffffff" stroke="#000"/> <rect x="320" y="144" width="16" height="16" fill="#ffffff" stroke="#000"/> <rect x="394" y="144" width="16" height="16" fill="#ffffff" stroke="#000"/> <text x="260" y="200" font-size="10" text-anchor="middle" fill="#666">Schematicky nakres prostoroveho telesa (viz testovy sesit).</text> </svg>',
  'krychle-vyrezy.svg',
  'Krychle o hraně 10 cm a nové těleso se čtyřmi vyříznutými rohovými krychličkami o hraně 2 cm (schematicky).',
  'Schematický nákres (prostorové těleso, viz testový sešit)',
  new List<String>{'Původní krychle má povrch $6\\cdot 10^2=600$ cm². Vyříznutím malé krychličky z rohu se z povrchu odeberou tři čtverce $2\\times 2$ (celkem $12$ cm²), ale současně se odkryjí tři nové stejně velké čtverce ($12$ cm²). Povrch se tedy nezmění. U všech čtyř rohových výřezů zůstává povrch $600$ cm².'},
  'C) $600$ cm²',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
