String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PND25C0T01';
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
  'CERMAT M9 nanečisto 2025 – úloha 14',
  new List<String>{'Dřevěný domeček se skládá ze dvou kolmých hranolů a stojí na vodorovné podložce. Plocha, kterou se domeček dotýká podložky, má obsah $16$ cm². V obrázku jsou označeny některé rozměry hranolů. Platí $v=a$.','Jaký je objem domečku?'},
  new List<String>{'A) $42$ cm³','B) $48$ cm³','C) $56$ cm³','D) $64$ cm³','E) jiný objem'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 240" font-family="sans-serif"> <polygon points="60,120 60,200 140,200 140,120 100,70" fill="#f0f0f0" stroke="#000" stroke-width="2"/> <line x1="140" y1="200" x2="250" y2="160" stroke="#000" stroke-width="1.5" stroke-dasharray="4 4"/> <line x1="140" y1="120" x2="250" y2="80" stroke="#000" stroke-width="1.5" stroke-dasharray="4 4"/> <line x1="100" y1="70" x2="210" y2="30" stroke="#000" stroke-width="1.5" stroke-dasharray="4 4"/> <polyline points="250,160 250,80 210,30" fill="none" stroke="#000" stroke-width="1.5" stroke-dasharray="4 4"/> <line x1="60" y1="214" x2="140" y2="214" stroke="#000" stroke-width="1"/> <text x="96" y="228" font-size="14" font-style="italic">a</text> <text x="44" y="166" font-size="14" font-style="italic">a</text> <text x="104" y="103" font-size="13" font-style="italic">v</text> <text x="184" y="200" font-size="14" font-style="italic">4a</text> </svg>',
  'domecek.svg',
  'Schematický nákres domečku složeného z kvádru a trojbokého hranolu (střechy) s rozměry a, 4a a výškou v.',
  'Schematický nákres domečku',
  new List<String>{'Dolní podstava kvádru má rozměry $a\\times 4a$ a dotýká se podložky: $4a^2=16$, tedy $a=2$ cm.','Objem kvádru: $a\\cdot 4a\\cdot a=4a^3=4\\cdot 8=32$ cm³. Objem střešního trojbokého hranolu: $\\frac{1}{2}\\cdot a\\cdot v\\cdot 4a=\\frac{1}{2}\\cdot a\\cdot a\\cdot 4a=2a^3=16$ cm³.','Celkový objem $32+16=48$ cm³.'},
  'B) $48$ cm³',
  2, 6, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Tři pětiny objemu nádoby jsou zaplněny vodou. Celou nádobu zaplníme po dolití dalších 14 litrů vody. (Nádoba nepřeteče.) Jaký je objem nádoby?','15.2 Voda v nádobě vyplňuje $55\\,\\%$ jejího objemu. Když z nádoby odebereme 12 litrů vody, bude zaplněna přesně čtvrtina objemu nádoby. Jaký je objem nádoby?','15.3 V každé ze tří stejných nádob je nalito jiné množství vody. V první nádobě vyplňuje voda $30\\,\\%$ jejího objemu a ve druhé nádobě $40\\,\\%$ objemu. Ve třetí nádobě je 19 litrů vody. Kdybychom vodu ze všech nádob rozdělili rovnoměrně, voda by v každé nádobě vyplnila dvě pětiny jejího objemu. Jaký je objem jedné nádoby?'},
  new List<String>{'A) 30 litrů','B) 33 litrů','C) 35 litrů','D) 38 litrů','E) 40 litrů','F) jiný objem'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Dolitých 14 litrů odpovídá $1-\\frac{3}{5}=\\frac{2}{5}$ objemu, objem $=14:\\frac{2}{5}=35$ litrů → C.','15.2 Odebraných 12 litrů odpovídá $55\\,\\%-25\\,\\%=30\\,\\%$ objemu, objem $=12:0{,}3=40$ litrů → E.','15.3 Nechť $V$ je objem nádoby. Celkem vody $0{,}3V+0{,}4V+19=1{,}2V$ (tj. $3\\cdot 0{,}4V$). Odtud $0{,}5V=19$, $V=38$ litrů → D.'},
  '15.1: C (35 litrů); 15.2: E (40 litrů); 15.3: D (38 litrů)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
