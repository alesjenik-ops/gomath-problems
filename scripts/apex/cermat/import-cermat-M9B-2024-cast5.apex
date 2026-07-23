String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD24C0T02';
Integer YEAR = 2024;

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
  'CERMAT M9B 2024 - uloha 13',
  new List<String>{'V rovine lezi primky $k$, $l$, $m$ a $n$. Pruseciky primek $k$, $l$ a $m$ tvori vrcholy trojuhelniku $ABC$. Bodem $B$ prochazi take primka $n$. Na obrazku jsou vyznaceny uhly $125^\\circ$ u vrcholu $C$, $105^\\circ$ u vrcholu $A$ a pravy uhel u vrcholu $B$; hledany uhel je oznacen $\\alpha$.','Jaka je velikost uhlu $\\alpha$? Velikosti uhlu nemerte, ale vypocitejte (obrazek je ilustracni).'},
  new List<String>{'A) $55^\\circ$','B) $50^\\circ$','C) $45^\\circ$','D) $40^\\circ$','E) $35^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 490 260" font-family="sans-serif"> <line x1="88" y1="240" x2="182" y2="26" stroke="#000" stroke-width="1.6"/> <line x1="120" y1="56" x2="452" y2="168" stroke="#000" stroke-width="1.6"/> <line x1="66" y1="216" x2="462" y2="136" stroke="#000" stroke-width="1.6"/> <line x1="400" y1="40" x2="400" y2="216" stroke="#000" stroke-width="1.6"/> <text x="186" y="26" font-size="15" font-style="italic">k</text> <text x="458" y="174" font-size="15" font-style="italic">l</text> <text x="466" y="132" font-size="15" font-style="italic">m</text> <text x="392" y="34" font-size="15" font-style="italic">n</text> <text x="150" y="76" font-size="14" font-style="italic">C</text> <text x="92" y="222" font-size="14" font-style="italic">A</text> <text x="406" y="168" font-size="14" font-style="italic">B</text> <text x="152" y="100" font-size="13">125°</text> <text x="106" y="204" font-size="13">105°</text> <text x="358" y="152" font-size="13">90°</text> <text x="372" y="126" font-size="15" font-style="italic">a</text> </svg>',
  'primky-uhly.svg',
  'Trojuhelnik ABC tvoreny primkami k, l, m a primka n prochazejici vrcholem B; vyznacene uhly 125 stupnu u C, 105 stupnu u A, pravy uhel a uhel alfa u B.',
  'Schematicky nakres k uloze 13 (ilustracni)',
  new List<String>{'Vnitrni uhly trojuhelniku: u $A$ je $180^\\circ-105^\\circ=75^\\circ$, u $C$ je $180^\\circ-125^\\circ=55^\\circ$, u $B$ tedy $180^\\circ-75^\\circ-55^\\circ=50^\\circ$. Primka $n$ svira s primkou $l$ pravy uhel, proto $\\alpha=90^\\circ-50^\\circ=40^\\circ$.'},
  'D) $40^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2024 - uloha 14',
  new List<String>{'Ve ctvercove siti je zakreslen sedy obrazec - pulkruh s prumerem $AB$. Body $A$ a $B$ lezi v mrizovych bodech. Delka strany ctverce ve ctvercove siti je $2$ cm.','Jaky je obsah sede casti? Pro vypocet pouzijte zaokrouhlenou hodnotu cisla $\\pi\\doteq 3{,}14$.'},
  new List<String>{'A) $20{,}28$ cm$^2$','B) $22{,}56$ cm$^2$','C) $24{,}56$ cm$^2$','D) $25{,}12$ cm$^2$','E) $30{,}24$ cm$^2$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 220" font-family="sans-serif"> <path d="M 60 80 A 80 80 0 0 0 220 80 Z" fill="#b9b9b9" stroke="#000" stroke-width="1.5"/> <g stroke="#000" stroke-width="1"> <line x1="60" y1="40" x2="220" y2="40"/> <line x1="60" y1="80" x2="220" y2="80"/> <line x1="60" y1="120" x2="220" y2="120"/> <line x1="60" y1="160" x2="220" y2="160"/> <line x1="60" y1="200" x2="220" y2="200"/> <line x1="60" y1="40" x2="60" y2="200"/> <line x1="100" y1="40" x2="100" y2="200"/> <line x1="140" y1="40" x2="140" y2="200"/> <line x1="180" y1="40" x2="180" y2="200"/> <line x1="220" y1="40" x2="220" y2="200"/> </g> <text x="46" y="76" font-size="14" font-style="italic">A</text> <text x="226" y="76" font-size="14" font-style="italic">B</text> <line x1="240" y1="40" x2="240" y2="80" stroke="#000" stroke-width="1"/> <text x="248" y="64" font-size="13">2 cm</text> </svg>',
  'sit-pulkruh.svg',
  'Ctvercova sit se stranou ctverce 2 cm a sedym pulkruhem s prumerem AB lezicim na mrizove primce.',
  'Sedy pulkruh ve ctvercove siti (schematicky nakres)',
  new List<String>{'Prumer $|AB|$ odpovida ctyrem stranam ctvercove site, tj. $|AB|=4\\cdot 2=8$ cm, polomer $r=4$ cm. Obsah pulkruhu: $\\frac{1}{2}\\pi r^2=\\frac{1}{2}\\cdot 3{,}14\\cdot 16=25{,}12$ cm$^2$.'},
  'D) $25{,}12$ cm$^2$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
