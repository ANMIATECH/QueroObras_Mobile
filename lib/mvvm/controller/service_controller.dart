import '../const/export.dart';

class ServiceController extends GetxController {
  final ApiManager _apiManager = ApiManager();
  RxList<dynamic> categories = <dynamic>[].obs;
  RxList<dynamic> cCategories = <dynamic>[].obs;
  RxList<dynamic> aCategories = <dynamic>[].obs;
  RxList providers = [].obs;
  var categoryName = ''.obs;
  RxList filteredProviders = [].obs;

  RxDouble myLat = 0.0.obs;
  RxDouble myLng = 0.0.obs;

  Future<void> getCurrentLocation() async {
    LocationPermission permission;

    // Check permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    }

    if (permission == LocationPermission.denied) {
      throw Exception("User denied location permission.");
    }

    // Now get location safely
    await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    // print("Current location: ${position.latitude}, ${position.longitude}");
  }

  Future<double> calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) async {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng) /
        1000; // km
  }

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (StorageDesign.validKey(
      StorageDesign.token,
    )) {
          getPopularServiceProvider();
    getCurrentLocation();
    getConstructionServiceProvider();
    getAcabamentoServiceProvider();
    loadNofication(isInitial: true);
    loadNoficationCpn(isInitial: true);
    }

  }

  @override
  void onClose() {}

  final RxList<Item> itemList =
      <Item>[].obs; // To store the list of fetched items
  final RxInt currentPage = 1.obs; // Tracks the current page number
  final RxInt itemsPerPage =
      10.obs; // Sets the limit (e.g., 10 items per request)
  final RxBool isLoadingNotification =
      false.obs; // Tracks initial loading state
  final RxBool isPaginating =
      false.obs; // Tracks loading state for subsequent pages (load more)
  final RxBool hasMoreData =
      true.obs; // Indicates if there are more pages to load
  final notificaitoncpnf = NotificationCpnf().obs;
  final RxList<dynamic> masterItemList = <dynamic>[].obs;

  void loadNextPage() {
    if (!isLoadingNotification.value &&
        !isPaginating.value &&
        hasMoreData.value) {
      loadNofication();
    }
  }

  void loadNextPageCpn() {
    if (!isLoadingNotification.value &&
        !isPaginating.value &&
        hasMoreData.value) {
      loadNoficationCpn();
    }
  }

  final requestPricing = TextEditingController();
  final notePricing = TextEditingController();
  var approveRequestIsLoading = false.obs;

  Future<void> approveRequest({required String id}) async {
    if (requestPricing.text.isEmpty) {
      CustomLoading.showNotification(
        message: 'Por favor, insira um preço',
        messageType: MessageType.error,
      );
      return;
    }
    try {
      final Map<String, dynamic> body = {
        'amount': num.parse(requestPricing.text.trim()),
        'note': notePricing.text.trim(),
      };
      approveRequestIsLoading.value = true;
      var response = await _apiManager.post(
        "${ApiUrl.serviceRequests}/$id/reply",
        body,
        true,
      );
      approveRequestIsLoading.value = false;

      if (response.statusCode == 201) {
        requestPricing.clear();
        notePricing.clear();
        CustomLoading.showNotification(
          message: 'Preço da solicitação enviado com sucesso.',
          messageType: MessageType.success,
        );
        Get.back();
      } else {
        CustomLoading.showNotification(
          message: 'Falha ao aprovar a solicitação.',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      approveRequestIsLoading.value = false;

      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    } finally {
      approveRequestIsLoading.value = false;
    }
  }
  Future<void> completeRequestClient({required String id}) async {
  
    try {
    
      approveRequestIsLoading.value = true;
      var response = await _apiManager.post(
        "${ApiUrl.serviceRequests}/$id/confirm-completion",
        {},
        true,
      );

      if (response.statusCode == 200) {
       
        CustomLoading.showNotification(
          message: 'Conclusão confirmada',
          messageType: MessageType.success,
        );
        Get.back();
      } else {
        CustomLoading.showNotification(
          message: 'Falha ao aprovar a solicitação.',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      approveRequestIsLoading.value = false;

      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    } finally {
      approveRequestIsLoading.value = false;
    }
  }

  Future<void> completedRequest({required String id}) async {
    try {
      var response = await _apiManager.post(
        "${ApiUrl.serviceRequests}/$id/mark-completed",
        {},
        true,
      );

      if (response.statusCode == 200) {
        await loadNofication(isInitial: true);
        Get.back();
        CustomLoading.showNotification(
          message: 'Serviço concluído',
          messageType: MessageType.success,
        );
        Get.back();
      } else {
        CustomLoading.showNotification(
          message: 'Conclusão Rejeitada',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    } finally {}
  }

  Future<void> rejectRequest({required String id}) async {
    try {
      final Map<String, dynamic> body = {};
      approveRequestIsLoading.value = true;
      var response = await _apiManager.post(
        "${ApiUrl.serviceRequests}/$id/reject",
        body,
        true,
      );
      approveRequestIsLoading.value = false;

      if (response.statusCode == 200) {
        await loadNoficationCpn(isInitial: true);
        requestPricing.clear();
        notePricing.clear();
        CustomLoading.showNotification(
          message: 'Solicitação rejeitada com sucesso.',
          messageType: MessageType.success,
        );
        Get.back();
      } else {
        CustomLoading.showNotification(
          message: 'Falha ao rejeitar a solicitação.',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      approveRequestIsLoading.value = false;

      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    } finally {
      approveRequestIsLoading.value = false;
    }
  }

  Future loadNofication({bool isInitial = false}) async {
    if (!hasMoreData.value && !isInitial) {
      return; // Stop if no more data is available
    }
    // Set loading state based on whether it's the first load or a "load more"
    if (isInitial) {
      isLoadingNotification.value = true;
      currentPage.value = 1; // Reset to page 1 for initial load/refresh
      itemList.clear(); // Clear list for initial load/refresh
      hasMoreData.value = true;
    } else {
      isPaginating.value = true;
    }

    try {
      final Map<String, String> params = {
        'page': currentPage.value.toString(),
        'per_page': itemsPerPage.value.toString(),
      };

      var response = await _apiManager.read(
        ApiUrl.serviceRequestAssigned,
        true,
        params,
      );

      jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        notificaitoncpnf.value = NotificationCpnf.fromJson(data);

        final List<DatumCpnf> fetchedItems =
            notificaitoncpnf.value.data?.datacpnf ?? [];
        final int totalPages =
            notificaitoncpnf.value.data?.lastPage ??
            1; // Adjust keys based on your API

        if (fetchedItems.isNotEmpty) {
          // itemList.addAll(fetchedItems);
          masterItemList.addAll(fetchedItems);

          // Increment page number for the next request
          currentPage.value++;
        }

        // Check if the current page is the last page
        if (currentPage.value > totalPages) {
          hasMoreData.value = false;
        }
      } else {
        // Handle API errors (e.g., 404, 500)
        CustomLoading.showNotification(
          message: 'Falha ao carregar os itens.',
          messageType: MessageType.error,
        );
        hasMoreData.value =
            false; // Prevent further attempts if server error occurs
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    } finally {
      isLoadingNotification.value = false;
      isPaginating.value = false;
    }
  }

  final RxList<Item> itemListCpn =
      <Item>[].obs; // To store the list of fetched items
  final RxInt currentPageCpn = 1.obs; // Tracks the current page number
  final RxInt itemsPerPageCpn =
      10.obs; // Sets the limit (e.g., 10 items per request)
  final RxBool isLoadingNotificationCpn =
      false.obs; // Tracks initial loading state
  final RxBool isPaginatingCpn =
      false.obs; // Tracks loading state for subsequent pages (load more)
  final RxBool hasMoreDataCpn =
      true.obs; // Indicates if there are more pages to load
  final notificaitoncpnfCpn = NotificationCpnf().obs;
  final notificaitoncpn = NotificationCpn().obs;
  final RxList<dynamic> masterItemListCpn = <dynamic>[].obs;

  Future loadNoficationCpn({bool isInitial = false}) async {
    if (!hasMoreDataCpn.value && !isInitial) {
      return; // Stop if no more data is available
    }
    // Set loading state based on whether it's the first load or a "load more"
    if (isInitial) {
      isLoadingNotificationCpn.value = true;
      currentPageCpn.value = 1; // Reset to page 1 for initial load/refresh
      itemListCpn.clear(); // Clear list for initial load/refresh
      hasMoreDataCpn.value = true;
    } else {
      isPaginatingCpn.value = true;
    }

    try {
      final Map<String, String> params = {
        'page': currentPage.value.toString(),
        'per_page': itemsPerPage.value.toString(),
      };

      var response = await _apiManager.read(
        ApiUrl.myServiceRequest,
        true,
        params,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        notificaitoncpn.value = NotificationCpn.fromJson(data);

        final List<DatumCpn> fetchedItems =
            notificaitoncpn.value.data?.data ?? [];
        final int totalPages =
            notificaitoncpn.value.data?.lastPage ??
            1; // Adjust keys based on your API

        if (fetchedItems.isNotEmpty) {
          // itemList.addAll(fetchedItems);
          masterItemListCpn.addAll(fetchedItems);

          // Increment page number for the next request
          currentPageCpn.value++;
        }

        // Check if the current page is the last page
        if (currentPageCpn.value > totalPages) {
          hasMoreDataCpn.value = false;
        }
      } else {
        // Handle API errors (e.g., 404, 500)
        CustomLoading.showNotification(
          message: 'Falha ao carregar os itens.',
          messageType: MessageType.error,
        );
        hasMoreDataCpn.value =
            false; // Prevent further attempts if server error occurs
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    } finally {
      isLoadingNotificationCpn.value = false;
      isPaginatingCpn.value = false;
    }
  }

  Future<void> getPopularServiceProvider() async {
    try {
      var response = await _apiManager.read(ApiUrl.popularCategory, false);
print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        categories.value = data["categories"] ?? [];
      } else {
        var message = jsonDecode(response.body);
        var error =
            message["error"]?["message"] ?? "Falha ao buscar categorias";
        print(response.body);

        CustomLoading.showNotification(
          message: error,
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  Future<void> getConstructionServiceProvider() async {
    try {
      var response = await _apiManager.read(ApiUrl.constructionCategory, false);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        cCategories.value = data["categories"] ?? [];
      } else {
        var message = jsonDecode(response.body);
        var error =
            message["error"]?["message"] ?? "Falha ao buscar categorias";

        CustomLoading.showNotification(
          message: error,
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  // 👈 New: Function to remove an image
  void removeImage(File file) {
    selectedImages.remove(file);
  }

  Future<void> getAcabamentoServiceProvider() async {
    try {
      var response = await _apiManager.read(ApiUrl.acabamentoCategory, false);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        aCategories.value = data["categories"] ?? [];
      } else {
        var message = jsonDecode(response.body);
        var error =
            message["error"]?["message"] ?? "Falha ao buscar categorias";

        CustomLoading.showNotification(
          message: error,
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  Future<void> getPopularServiceProviderBySlug(String slug) async {
    try {
      final url = "v1/category/$slug/users";

      var response = await _apiManager.read(url, false);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        providers.value = data["users"] ?? [];
        filteredProviders.value = List.from(providers);

        categoryName.value = data["category"]?["name"] ?? "";
      } else {
        var message = jsonDecode(response.body);
        var error = message["error"]?["message"] ?? "Falha ao buscar prestadores de serviço";
        CustomLoading.showNotification(
          message: error,
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  // 🔎 Search filter
  void filterProviders(String query) {
    if (query.isEmpty) {
      filteredProviders.value = providers;
    } else {
      filteredProviders.value = providers.where((provider) {
        final name = (provider['name'] ?? '').toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    }
  }

  final RxList<File> selectedImages = <File>[].obs;
  final int maxImages = 5; // Set a limit for the number of images
  final ImagePicker _picker = ImagePicker();
  var isCreateItemLoading = false.obs;

  // 👈 New: Function to pick multiple images
  Future<void> pickImages() async {
    // Calculate how many more images can be added
    int remainingSlots = maxImages - selectedImages.length;

    // Only proceed if there are slots available
    if (remainingSlots > 0) {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        limit: remainingSlots,
        imageQuality: 70, // Adjust image quality as needed
      );

      if (pickedFiles.isNotEmpty) {
        // Convert XFile to File and add to the observable list
        for (var xFile in pickedFiles) {
          selectedImages.add(File(xFile.path));
        }
      }
    } else {
      CustomLoading.showNotification(
        message: "Você pode enviar no máximo $maxImages imagens.",
        messageType: MessageType.info,
      );
    }
  }

  final addressRequest = TextEditingController();
  final serviceToMake = TextEditingController();

  // 👈 Updated: Publish Item Logic
  Future<void> sendRequest(dynamic context, String serviceProviderId) async {
    // 1. Validation
    if (addressRequest.text.isEmpty || serviceToMake.text.isEmpty) {
      CustomLoading.showNotification(
        message: 'Por favor, preencha todos os campos.',
        messageType: MessageType.error,
      );
      return;
    }

    // if (selectedImages.isEmpty) {
    //   CustomLoading.showNotification(
    //     message: 'Por favor, envie pelo menos uma imagem.',
    //     messageType: MessageType.error,
    //   );
    //   return;
    // }

    // 2. Prepare Data
    final Map<String, String> data = {
      "service_provider_id": serviceProviderId,
      'address': addressRequest.text,
      'description': serviceToMake.text,
    };

    try {
      isCreateItemLoading.value = true;
      FocusScope.of(context).unfocus();

      final response = await _apiManager.uploadMultipleFilesWithData(
        endpoint: ApiUrl.serviceRequests,
        files: selectedImages.toList(),
        data: data,
        fileField: 'images[]',
        bearerToken: true,
      );

      // 🔴 IMPORTANT: Read the response stream ONCE
      final responseBody = await response.stream.bytesToString();

      // // ✅ PRINT RESPONSE
      // debugPrint("STATUS CODE: ${response.statusCode}");
      // debugPrint("RESPONSE BODY: $responseBody");
      // debugPrint("SENDING serviceProviderId => $serviceProviderId");
      // debugPrint("TYPE => ${serviceProviderId.runtimeType}");

      isCreateItemLoading.value = false;

      if (response.statusCode == 201) {
        addressRequest.clear();
        serviceToMake.clear();

        CustomLoading.showNotification(
          message: "Solicitação enviada",
          messageType: MessageType.success,
        );

        Get.back();
        Get.back();
        Get.back();
      } else {
        final decoded = responseBody.isNotEmpty
            ? jsonDecode(responseBody)
            : null;

        String getPortugueseMessage(String message) {
          switch (message.toLowerCase()) {
            case 'you have a pending request':
              return 'Você já possui uma solicitação pendente.';
            case 'service provider not found':
              return 'Prestador de serviço não encontrado.';
            default:
              return message; // fallback to whatever message
          }
        }

        final rawMessage =
            decoded?['error']?['message'] ??
                decoded?['message'] ??
                'Falha ao publicar o item.';

        final message = getPortugueseMessage(rawMessage);


        CustomLoading.showNotification(
          message: message,
          messageType: MessageType.error,
        );
      }
    } on Exception catch (e) {
      isCreateItemLoading.value = false;

      debugPrint("EXCEPTION: ${e.toString()}");

      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      CustomLoading.showNotification(
        message: errorMessage,
        messageType: MessageType.error,
      );
    } catch (e) {
      isCreateItemLoading.value = false;

      debugPrint("UNEXPECTED ERROR: ${e.toString()}");

      CustomLoading.showNotification(
        message: 'Ocorreu um erro inesperado: ${e.toString()}',
        messageType: MessageType.error,
      );
    }
  }
}
