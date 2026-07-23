String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PND26C0T01';
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
  'CERMAT M9 nanečisto 2026 – úloha 11',
  new List<String>{'Graf udává délky tréninkových tras tří cyklistů (Adam, Ben, Cyril) během dvou víkendových dní; tmavé sloupce jsou sobota, světlé neděle. Všechny díly na svislé ose jsou stejné. Za celý víkend ujel Adam o 45 km méně než Ben.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Vzdálenosti, které za celý víkend ujeli Adam, Ben a Cyril (v tomto pořadí), jsou v poměru $3:4:5$.','11.2 V neděli ujel Cyril o 40 % delší trasu než Adam.','11.3 Ben ujel v sobotu méně než 100 km.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 340" font-family="sans-serif"><line x1="70" y1="40" x2="70" y2="290" stroke="#000"/><line x1="70" y1="290" x2="490" y2="290" stroke="#000"/><line x1="70" y1="262" x2="480" y2="262" stroke="#e0e0e0"/><line x1="70" y1="234" x2="480" y2="234" stroke="#e0e0e0"/><line x1="70" y1="206" x2="480" y2="206" stroke="#e0e0e0"/><line x1="70" y1="178" x2="480" y2="178" stroke="#e0e0e0"/><line x1="70" y1="150" x2="480" y2="150" stroke="#e0e0e0"/><line x1="70" y1="122" x2="480" y2="122" stroke="#e0e0e0"/><line x1="70" y1="94" x2="480" y2="94" stroke="#e0e0e0"/><text x="62" y="294" font-size="12" text-anchor="end">0</text><rect x="110" y="234" width="26" height="56" fill="#555" stroke="#000"/><rect x="144" y="178" width="26" height="112" fill="#d8d8d8" stroke="#000"/><text x="140" y="308" font-size="13" text-anchor="middle">Adam</text><rect x="222" y="150" width="26" height="140" fill="#555" stroke="#000"/><rect x="256" y="206" width="26" height="84" fill="#d8d8d8" stroke="#000"/><text x="252" y="308" font-size="13" text-anchor="middle">Ben</text><rect x="334" y="206" width="26" height="84" fill="#555" stroke="#000"/><rect x="368" y="94" width="26" height="196" fill="#d8d8d8" stroke="#000"/><text x="364" y="308" font-size="13" text-anchor="middle">Cyril</text><text x="24" y="175" font-size="12" text-anchor="middle" transform="rotate(-90 24 175)">Ujeta vzdalenost v km</text><rect x="150" y="315" width="12" height="12" fill="#555" stroke="#000"/><text x="168" y="325" font-size="12">Sobota</text><rect x="250" y="315" width="12" height="12" fill="#d8d8d8" stroke="#000"/><text x="268" y="325" font-size="12">Nedele</text></svg>',
  'graf-cykliste.svg',
  'Skupinový sloupcový graf ujetých vzdáleností Adama, Bena a Cyrila v sobotu a v neděli.',
  'Ujeté vzdálenosti (díly svislé osy jsou stejné)',
  new List<String>{'V dílech osy: Adam $2+4=6$, Ben $5+3=8$, Cyril $3+7=10$.','11.1 $6:8:10=3:4:5$ — pravda (A).','Rozdíl Ben a Adam je $8-6=2$ díly $=45$ km, tedy $1$ díl $=22{,}5$ km (Adam $135$ km, Ben $180$ km, Cyril $225$ km).','11.2 Cyril v neděli $7$ dílů, Adam v neděli $4$ díly; $7=1{,}75\\cdot 4$, tj. o $75$ % více, ne o $40$ % — nepravda (N).','11.3 Ben v sobotu $5$ dílů $=112{,}5$ km, což není méně než $100$ km — nepravda (N).'},
  '11.1: Ano; 11.2: Ne; 11.3: Ne',
  4, 6, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 12',
  new List<String>{'V kvádru o rozměrech 2 cm, 4 cm a 2 cm byla vytvořena prohlubeň vyříznutím poloviny válce s podstavou o poloměru 1 cm (viz obrázek).','Jaký je objem tělesa s prohlubní? Ve výpočtu použijte $\\pi\\doteq 3{,}14$.'},
  new List<String>{'A) $3{,}44$ cm³','B) $9{,}72$ cm³','C) $10{,}72$ cm³','D) $12{,}56$ cm³','E) jiný objem'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 200" font-family="sans-serif"> <polygon points="40,70 180,70 230,40 90,40" fill="#e6e6e6" stroke="#000"/> <polygon points="40,70 40,160 180,160 180,70" fill="#d0d0d0" stroke="#000"/> <polygon points="180,70 230,40 230,130 180,160" fill="#bcbcbc" stroke="#000"/> <path d="M85 70 a25 22 0 0 0 50 0" fill="#f2f2f2" stroke="#000"/> <line x1="110" y1="70" x2="110" y2="108" stroke="#000" stroke-dasharray="2 3"/> <text x="14" y="120" font-size="12">2 cm</text> <text x="100" y="178" font-size="12">2 cm</text> <text x="194" y="140" font-size="12">4 cm</text> <text x="116" y="98" font-size="12">1 cm</text> </svg>',
  'kvadr-prohluben.svg',
  'Kvádr 2 cm krát 4 cm krát 2 cm s půlválcovou prohlubní o poloměru 1 cm podél delší hrany.',
  'Schematický nákres tělesa s prohlubní',
  new List<String>{'Objem kvádru $2\\cdot 4\\cdot 2=16$ cm³. Odebraný půlválec má poloměr $1$ cm a délku $4$ cm: $\\frac{1}{2}\\pi r^2\\cdot 4=\\frac{1}{2}\\cdot 3{,}14\\cdot 1\\cdot 4=6{,}28$ cm³. Těleso s prohlubní: $16-6{,}28=9{,}72$ cm³.'},
  'B) $9{,}72$ cm³',
  2, 5, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
