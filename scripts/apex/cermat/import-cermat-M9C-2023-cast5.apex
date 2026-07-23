String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD23C0T03';
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
  'CERMAT M9C 2023 – úloha 13',
  new List<String>{'Pětiúhelník $ABCDE$ se skládá z rovnoramenného, rovnostranného a pravoúhlého trojúhelníku. Základnou rovnoramenného trojúhelníku je strana $AB$. Strany $BC$ a $AE$ pětiúhelníku jsou rovnoběžné. Vnitřní úhel při vrcholu $A$ má velikost $55^\\circ$ (viz obrázek).','Jaká je velikost úhlu $\\omega$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $65^\\circ$','B) $70^\\circ$','C) $75^\\circ$','D) $80^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 300" font-family="sans-serif"> <polygon points="80,250 410,250 545,155 475,95 275,120" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="275" y1="120" x2="410" y2="250" stroke="#000"/> <line x1="475" y1="95" x2="410" y2="250" stroke="#000"/> <text x="64" y="266" font-size="15" font-style="italic">A</text> <text x="405" y="272" font-size="15" font-style="italic">B</text> <text x="556" y="158" font-size="15" font-style="italic">C</text> <text x="478" y="86" font-size="15" font-style="italic">D</text> <text x="255" y="116" font-size="15" font-style="italic">E</text> <text x="118" y="243" font-size="13">55°</text> <text x="466" y="128" font-size="14" font-style="italic">ω</text> <rect x="515" y="150" width="11" height="11" fill="none" stroke="#000" transform="rotate(35 520 155)"/> <text x="178" y="180" font-size="15">›</text> <text x="474" y="206" font-size="15">›</text> </svg>',
  'petiuhelnik.svg',
  'Pětiúhelník ABCDE rozdělený na tři trojúhelníky; u vrcholu A je úhel 55 stupňů, u vrcholu C je pravý úhel a u vrcholu D je hledaný úhel omega.',
  'Pětiúhelník ABCDE (schematický nákres)',
  new List<String>{'Rovnoramenný trojúhelník $ABE$ má základnu $AB$, proto $|\\angle EAB|=|\\angle EBA|=55^\\circ$. Prostřední trojúhelník $EBD$ je rovnostranný, tedy $|\\angle EBD|=60^\\circ$.','Protože $BC\\parallel AE$, je vnitřní úhel pětiúhelníku při vrcholu $B$ roven $180^\\circ-55^\\circ=125^\\circ$. Skládá se z úhlů $\\angle ABE=55^\\circ$, $\\angle EBD=60^\\circ$ a $\\angle DBC$, proto $|\\angle DBC|=125^\\circ-55^\\circ-60^\\circ=10^\\circ$.','Trojúhelník $BCD$ je pravoúhlý s pravým úhlem u vrcholu $C$, takže $\\omega=|\\angle BDC|=90^\\circ-10^\\circ=80^\\circ$.'},
  'D) $80^\\circ$',
  2, 5, '4',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2023 – úloha 14',
  new List<String>{'Povrch pravidelného čtyřbokého hranolu je $144$ cm². Obsah pláště tohoto hranolu je dvakrát větší než obsah jedné jeho čtvercové podstavy. (Plášť tohoto hranolu tvoří čtyři shodné boční stěny.) Viz obrázek.','Jaký je objem hranolu?'},
  new List<String>{'A) $72$ cm³','B) $108$ cm³','C) $144$ cm³','D) $216$ cm³','E) jiný objem'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 170" font-family="sans-serif"> <polygon points="40,90 180,90 180,140 40,140" fill="#eef4fa" stroke="#000"/> <polygon points="40,90 90,55 230,55 180,90" fill="#eef4fa" stroke="#000"/> <polygon points="180,90 230,55 230,105 180,140" fill="#eef4fa" stroke="#000"/> <line x1="40" y1="140" x2="90" y2="105" stroke="#000" stroke-dasharray="4 3"/> <line x1="90" y1="105" x2="230" y2="105" stroke="#000" stroke-dasharray="4 3"/> <line x1="90" y1="105" x2="90" y2="55" stroke="#000" stroke-dasharray="4 3"/> </svg>',
  'hranol.svg',
  'Pravidelný čtyřboký hranol (kvádr se čtvercovou podstavou) nakreslený schematicky.',
  'Pravidelný čtyřboký hranol (schematický nákres)',
  new List<String>{'Podstavou je čtverec o hraně $a$, výška hranolu je $v$. Obsah podstavy je $a^2$, obsah pláště $4av$. Ze zadání $4av=2a^2$, tedy $v=\\frac{a}{2}$.','Povrch $S=2a^2+4av=2a^2+2a^2=4a^2=144$, odtud $a^2=36$, $a=6$ cm a $v=3$ cm. Objem $V=a^2\\cdot v=36\\cdot 3=108$ cm³.'},
  'B) $108$ cm³',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
