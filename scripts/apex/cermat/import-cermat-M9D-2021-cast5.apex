String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD21C0T04';
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
  'CERMAT M9D 2021 – úloha 13',
  new List<String>{'Všechny díly stavebnice jsou pravidelné čtyřboké hranoly s rozměry $1$ cm $\\times$ $1$ cm $\\times$ $2$ cm. Ve stavbě, která má podobu tří spojených kvádrů, jsou jednotlivé díly naskládány bez mezer tak, aby stavba obsahovala co největší počet stojících dílů. Stojící díl má dole čtvercovou stěnu, ležící díl nikoli. Rozměry v obrázku jsou v cm.','Kolik ležících dílů stavba obsahuje?'},
  new List<String>{'A) $0$','B) $6$','C) $12$','D) $18$','E) $24$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 470" font-family="sans-serif"><polygon points="110,278 176,278 228,238 162,238" fill="#f0f0f0" stroke="#000" stroke-width="2"/><polygon points="176,256 242,256 294,216 228,216" fill="#f0f0f0" stroke="#000" stroke-width="2"/><polygon points="242,300 308,300 360,260 294,260" fill="#f0f0f0" stroke="#000" stroke-width="2"/><polygon points="308,410 308,300 360,260 360,370" fill="#dcdcdc" stroke="#000" stroke-width="2"/><polygon points="242,300 242,256 294,216 294,260" fill="#dcdcdc" stroke="#000" stroke-width="2"/><polygon points="110,278 176,278 176,410 110,410" fill="#ffffff" stroke="#000" stroke-width="2"/><polygon points="176,256 242,256 242,410 176,410" fill="#ffffff" stroke="#000" stroke-width="2"/><polygon points="242,300 308,300 308,410 242,410" fill="#ffffff" stroke="#000" stroke-width="2"/><line x1="96" y1="410" x2="96" y2="278" stroke="#000" stroke-width="1"/><text x="88" y="348" font-size="15" text-anchor="end">6</text><line x1="368" y1="260" x2="368" y2="370" stroke="#000" stroke-width="1"/><text x="374" y="320" font-size="15">5</text><line x1="302" y1="216" x2="302" y2="260" stroke="#000" stroke-width="1"/><text x="308" y="252" font-size="15">2</text><text x="132" y="252" font-size="15">4</text><text x="143" y="432" font-size="15" text-anchor="middle">3</text><text x="209" y="432" font-size="15" text-anchor="middle">3</text><text x="275" y="432" font-size="15" text-anchor="middle">3</text><text x="235" y="205" font-size="15" text-anchor="middle" font-style="italic">Stavba</text></svg>',
  'stavba-kvadry.svg',
  'Stavba ze tří spojených kvádrů o společné hloubce 4 cm a šířkách po 3 cm; výšky zleva doprava jsou 6 cm, 7 cm a 5 cm.',
  'Stavba ze tří spojených kvádrů (rozměry v cm)',
  new List<String>{'Každý ze tří kvádrů má půdorys $3\\times 4$ (obsah $12$ čtverečních cm) a výšku po řadě $6$, $7$ a $5$ cm. Stojící díl je vysoký $2$ cm, proto zaplní svislý sloupec jen do sudé výšky. Levý kvádr má výšku $6$ cm (sudou) – je celý ze stojících dílů. Prostřední ($7$ cm) a pravý ($5$ cm) mají lichou výšku, takže jejich horní vrstva $1$ cm musí být z ležících dílů. Taková vrstva má obsah $3\\times 4=12$ čtverečků a jeden ležící díl ($2\\times 1$) pokryje $2$ čtverečky, tj. $6$ ležících dílů na kvádr. Celkem $6+6=12$.'},
  'C) $12$',
  2, 6, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2021 – úloha 14',
  new List<String>{'Ve třídě je o polovinu více chlapců než děvčat.','Které z následujících tvrzení je pravdivé?'},
  new List<String>{'A) Chlapci tvoří tři pětiny žáků třídy.','B) Děvčata tvoří $33$ % žáků třídy.','C) Počet žáků třídy je trojnásobkem počtu děvčat.','D) Počet dívek ve třídě je o polovinu menší než počet chlapců.','E) Žádné z výše uvedených tvrzení není pravdivé.'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Počet děvčat označme $2k$; chlapců je o polovinu více, tj. $3k$, žáků celkem $5k$. Chlapci tvoří $\\dfrac{3k}{5k}=\\dfrac{3}{5}$ (tři pětiny) – tvrzení A je pravdivé. Děvčata tvoří $40$ %, počet žáků je $2{,}5$násobek počtu děvčat a dívek je o třetinu méně než chlapců, takže ostatní tvrzení neplatí.'},
  'A) Chlapci tvoří tři pětiny žáků třídy.',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
