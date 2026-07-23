String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD19C0T01';
Integer YEAR = 2019;

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
  'CERMAT M7A 2019 – úloha 6',
  new List<String>{'Všechny modré a červené kuličky jsou rozděleny do tří stejně početných skupin A, B, C po $120$ kuličkách. Ve skupině A jsou jen modré kuličky a ve skupině B jen červené kuličky. Skupina C obsahuje čtvrtinu z celkového počtu modrých kuliček a zbytek červených.','6.1 Určete počet modrých kuliček ve skupině C.','6.2 Určete počet všech červených kuliček.','6.3 Vyjádřete v základním tvaru poměr počtu modrých a počtu červených kuliček ve skupině C (v uvedeném pořadí).'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Celkem $3\\cdot 120=360$ kuliček. Skupina A má $120$ modrých a skupina C obsahuje čtvrtinu všech modrých, takže $120$ modrých ze skupiny A jsou $\\frac{3}{4}$ všech modrých. Všech modrých je $160$, všech červených $360-160=200$.','6.1 Modrých v C je $\\frac{1}{4}\\cdot 160=40$.','6.2 Všech červených je $200$.','6.3 V C je $120-40=80$ červených; poměr modrých ku červeným $40:80=1:2$.'},
  '6.1: $40$; 6.2: $200$; 6.3: $1:2$',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2019 – úloha 7',
  new List<String>{'Ze dvou krychlí s hranou délky $10$ cm jsme vytvořili dvě nová tělesa. První těleso vzniklo z krychle po odříznutí části tvaru kvádru. Druhé těleso vzniklo z krychle po odříznutí části tvaru trojbokého hranolu. Nejkratší hrana prvního i druhého tělesa měří $7$ cm (viz obrázek).','7.1 Vypočtěte v cm³ objem prvního tělesa.','7.2 Vypočtěte v cm³ objem druhého tělesa.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 235" font-family="sans-serif" font-size="13"> <text x="105" y="18" text-anchor="middle">Prvni teleso</text> <text x="420" y="18" text-anchor="middle">Druhe teleso</text> <polygon points="40,150 150,150 150,205 40,205" fill="#efefef" stroke="#000" stroke-width="1.5"/> <polygon points="40,150 70,122 180,122 150,150" fill="#f7f7f7" stroke="#000" stroke-width="1.5"/> <polygon points="150,150 180,122 180,177 150,205" fill="#e3e3e3" stroke="#000" stroke-width="1.5"/> <polygon points="40,122 70,94 180,94 150,122" fill="none" stroke="#999" stroke-width="1" stroke-dasharray="4 4"/> <line x1="40" y1="150" x2="40" y2="122" stroke="#999" stroke-width="1" stroke-dasharray="4 4"/> <line x1="150" y1="150" x2="150" y2="122" stroke="#999" stroke-width="1" stroke-dasharray="4 4"/> <line x1="180" y1="122" x2="180" y2="94" stroke="#999" stroke-width="1" stroke-dasharray="4 4"/> <line x1="70" y1="122" x2="70" y2="94" stroke="#999" stroke-width="1" stroke-dasharray="4 4"/> <text x="95" y="223" text-anchor="middle">10 cm</text> <text x="185" y="183">7 cm</text> <polygon points="330,120 330,205 440,205 440,150" fill="#efefef" stroke="#000" stroke-width="1.5"/> <polygon points="330,120 358,100 468,130 440,150" fill="#f7f7f7" stroke="#000" stroke-width="1.5"/> <polygon points="440,150 468,130 468,185 440,205" fill="#e3e3e3" stroke="#000" stroke-width="1.5"/> <text x="308" y="168">10 cm</text> <text x="474" y="185">7 cm</text> <text x="385" y="223" text-anchor="middle">10 cm</text> </svg>',
  'telesa.svg',
  'Dvě tělesa vzniklá z krychle o hraně 10 cm: první odříznutím kvádru (nejkratší hrana 7 cm), druhé odříznutím trojbokého hranolu (nejkratší hrana 7 cm).',
  'První a druhé těleso (schematicky)',
  new List<String>{'7.1 První těleso je kvádr $10\\times 10\\times 7$: objem $10\\cdot 10\\cdot 7=700$ cm³.','7.2 Druhé těleso je hranol s podstavou pravoúhlého lichoběžníku se základnami $10$ cm a $7$ cm a výškou $10$ cm; obsah podstavy $\\frac{10+7}{2}\\cdot 10=85$ cm², objem $85\\cdot 10=850$ cm³.'},
  '7.1: $700$ cm³; 7.2: $850$ cm³',
  4, 6, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
